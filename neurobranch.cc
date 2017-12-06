/*****************************************************************
 * File: neurobranch.cc
 * Created on: 1-Nov-2017
 * Author: Ravi Raju Ayush Gupta Vijaytarang 
 ****************************************************************/

#include "cpu/pred/neurobranch.hh"

#include<iostream>
#include "base/bitfield.hh"
#include "base/intmath.hh"

NeuroBP::NeuroBP(const NeuroBPParams *params)
  : BPredUnit(params),
	globalPredictorSize(params->globalPredictorSize),
	globalHistory(params->numThreads, 0),
	globalHistoryBits(ceilLog2(params->globalPredictorSize))
{
  if (!isPowerOf2(globalPredictorSize)) {
	fatal("Invalid global predictor size!\n");
  }

  // Set up historyRegisterMask
  historyRegisterMask = mask(globalHistoryBits);

  // number of hashed perceptrons, i.e. each
  // one act as a local predictor corresponding to local history
  perceptronCount = 20;

  // Perceptron theta threshold parameter empirically determined in the
  // fast neural branch predictor paper to be 1.93 * history + 14
  //theta = 1.93 * globalPredictorSize + 14;
   theta = 1.93 * globalPredictorSize + (globalPredictorSize/2);
  // weights per neuron (historyRegister per neuron)
  weightsTable.assign(perceptronCount,
					  std::vector<unsigned>(globalPredictorSize + 1, 0));
  pastPCTable.assign(globalPredictorSize, 0);
  tc = 0;
  speed = 9;
  depth = 256;
  recency_stack.assign(depth, 0);

}

inline
void
NeuroBP::updateGlobalHistTaken(ThreadID tid)
{
  globalHistory[tid] = (globalHistory[tid] << 1) | 1;
  globalHistory[tid] = globalHistory[tid] & historyRegisterMask;
}

inline
void
NeuroBP::updateGlobalHistNotTaken(ThreadID tid)
{
  globalHistory[tid] = (globalHistory[tid] << 1);
  globalHistory[tid] = globalHistory[tid] & historyRegisterMask;
}

void
NeuroBP::btbUpdate(ThreadID tid, Addr branch_addr, void * &bp_history)
{
    //Update Global History to Not Taken (clear LSB)
    globalHistory[tid] &= (historyRegisterMask & ~ULL(1));
}

bool
NeuroBP::lookup(ThreadID tid, Addr branch_addr, void * &bp_history)
{
  // the current perceptron weights correspond to the ones
  // being hashed from the program counter and number of perceptrons
  int curPerceptron = branch_addr % perceptronCount;
  unsigned thread_history = globalHistory[tid];

  // the prediction is an indicator of the signed weighted sum
  int y_out = weightsTable[curPerceptron][0];
  
  for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out += weightsTable[curPerceptron][i];
	else y_out -= weightsTable[curPerceptron][i];
}
// the prediction is an indicator of the signed weighted sum
  int y_out1 = weightsTable[curPerceptron][0];
  for (int i = 1; i <= globalPredictorSize; i++) {
		
	int curPerceptron2 = pastPCTable[i] % perceptronCount;
		if ((thread_history >> (i - 1)) & 1)
			y_out1 += weightsTable[curPerceptron2][i];
		else y_out1 -= weightsTable[curPerceptron2][i];
	
}
 int y_out2 = weightsTable[curPerceptron][0];
 for(int i = 0; i < 256; i++)
 {	
	int curPerceptron3 = hashghistpath(tid, (unsigned)i) % perceptronCount;
	for(int j = 0; j < 32; j++)
	{
		if ((thread_history >> (i*32 + j)) & 1)
				y_out2 += weightsTable[curPerceptron3][i * 32 + j + 1];
			else y_out2 -= weightsTable[curPerceptron3][i * 32 + j + 1];
	}
 } 


//RECENCY 

int y_out3 = weightsTable[curPerceptron][0];
int curPerceptron4 = hash_recency(tid, depth) % perceptronCount;
for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out3 += weightsTable[curPerceptron4][i];
	else y_out3 -= weightsTable[curPerceptron4][i];
}

//RECENCY ENDS

//RECENCY POS 
int y_out4 = weightsTable[curPerceptron][0];
int curPerceptron5 = hash_recencypos(tid, branch_addr, depth) % perceptronCount;
for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out4 += weightsTable[curPerceptron5][i];
	else y_out4 -= weightsTable[curPerceptron5][i];
}
//RECENCY POS ENDS

 //int y_out_avg = (y_out + y_out1 + y_out2)/3;
int y_out_avg;


if (abs(y_out) > abs(y_out1)) {
	if (abs(y_out) > abs(y_out2)) y_out_avg = y_out;
	else y_out_avg = y_out2;
} else {
	if (abs(y_out1) > abs(y_out2)) y_out_avg = y_out1;
	else y_out_avg = y_out2;
}

if (y_out3 > y_out_avg) y_out_avg = y_out3;
if (y_out4 > y_out_avg) y_out_avg = y_out4;
/*
bool prediction;
bool a = (y_out >=  0);
bool b = (y_out1 >=  0);
bool c = (y_out2 >=  0);
int cnt = 0; 
if (a) cnt++;
if (b) cnt++;
if (c) cnt++;
if (cnt >=2) prediction = 1;
else prediction = 0;
*/

  bool prediction = (y_out_avg >= 0);

  // Create BPHistory and pass it back to be recorded.
  BPHistory *history       = new BPHistory;
  history->globalHistory   = globalHistory[tid];
  history->globalPredTaken = prediction;
  bp_history = (void *)history;

  return prediction;
}

unsigned NeuroBP::hashghistpath(ThreadID tid, unsigned shift)
{
	unsigned thread_history = globalHistory[tid];
	unsigned num = 0;
	for(int i = 0; i < 32; i++)
	{
		num += (thread_history & 1);
		thread_history = thread_history >> 1;
		num = num << 1;			
	}
	unsigned temp = 0;
	for(int i = 0; i < 32; i++)
	{
		temp += pastPCTable[i + 32 * shift];
		temp = temp << 1;	
	}
	temp ^= num;
	
	return temp;	
}



void
NeuroBP::uncondBranch(ThreadID tid, Addr pc, void * &bp_history)
{
  // Create BPHistory and pass it back to be recorded.
  BPHistory *history       = new BPHistory;
  history->globalHistory   = globalHistory[tid];
  history->globalPredTaken = true;
  history->globalUsed      = true;
  bp_history = static_cast<void *>(history);
  updateGlobalHistTaken(tid);
}

void
NeuroBP::update(ThreadID tid, Addr branch_addr, bool taken,
				void *bp_history, bool squashed)
{
  assert(bp_history);

  int curPerceptron = branch_addr % perceptronCount;
  unsigned thread_history = globalHistory[tid];

  // the prediction is an indicator of the signed weighted sum
  int y_out = weightsTable[curPerceptron][0];
  
  for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out += weightsTable[curPerceptron][i];
	else y_out -= weightsTable[curPerceptron][i];
}
// the prediction is an indicator of the signed weighted sum
  int y_out1 = weightsTable[curPerceptron][0];
  for (int i = 1; i <= globalPredictorSize; i++) {
		
	int curPerceptron2 = pastPCTable[i] % perceptronCount;
		if ((thread_history >> (i - 1)) & 1)
			y_out1 += weightsTable[curPerceptron2][i];
		else y_out1 -= weightsTable[curPerceptron2][i];
	
}

 int y_out2 = weightsTable[curPerceptron][0];
 for(int i = 0; i < 256; i++)
 {	
	int curPerceptron3 = hashghistpath(tid, (unsigned)i) % perceptronCount;
	for(int j = 0; j < 32; j++)
	{
		if ((thread_history >> (i*32 + j)) & 1)
				y_out2 += weightsTable[curPerceptron3][i * 32 + j + 1];
			else y_out2 -= weightsTable[curPerceptron3][i * 32 + j + 1];
	}
 } 

  int y_out3 = weightsTable[curPerceptron][0];
  int curPerceptron4 = hash_recency(tid, depth) % perceptronCount;

  for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out3 += weightsTable[curPerceptron4][i];
	else y_out3 -= weightsTable[curPerceptron4][i];
}

//RECENCY POS
int y_out4 = weightsTable[curPerceptron][0];
  int curPerceptron5 = hash_recencypos(tid, branch_addr, depth) % perceptronCount;

  for (int i = 1; i <= globalPredictorSize; i++) {
	if ((thread_history >> (i - 1)) & 1)
	  y_out4 += weightsTable[curPerceptron5][i];
	else y_out4 -= weightsTable[curPerceptron5][i];
}


//int y_out_avg = (y_out + y_out1 + y_out2)/3 ;
  int y_out_avg;


if (abs(y_out) > abs(y_out1)) {
	if (abs(y_out) > abs(y_out2)) y_out_avg = y_out;
	else y_out_avg = y_out2;
} else {
	if (abs(y_out1) > abs(y_out2)) y_out_avg = y_out1;
	else y_out_avg = y_out2;
}

if (y_out3 > y_out_avg) y_out_avg = y_out3;
if (y_out4 > y_out_avg) y_out_avg = y_out4;

  // If this is a misprediction, restore the speculatively
  // updated state (global history register and local history)
  // and update again.
  if (squashed || (abs(y_out_avg) <= theta)) {
    	if (taken) weightsTable[curPerceptron][0] += 1;
    	else       weightsTable[curPerceptron][0] -= 1;

    	// Have to update the corresponding weights to negatively reinforce
    	// the outcome of having predicted incorrectly
     
      for (int i = 1; i <= globalPredictorSize; i++) {
                
          int curPerceptron2 = pastPCTable[i] % perceptronCount;
          if (((thread_history >> (i - 1)) & 1) == taken)
 		weightsTable[curPerceptron2][i]    += 1;
      	  else weightsTable[curPerceptron2][i] -= 1;
        
               
          if (((thread_history >> (i - 1)) & 1) == taken)
      		  weightsTable[curPerceptron][i]    += 1;
      	  else weightsTable[curPerceptron][i] -= 1;

          if (((thread_history >> (i - 1)) & 1) == taken)
      		  weightsTable[curPerceptron4][i]    += 1;
      	  else weightsTable[curPerceptron4][i] -= 1;
   
     	  if (((thread_history >> (i - 1)) & 1) == taken)
      		  weightsTable[curPerceptron5][i]    += 1;
      	  else weightsTable[curPerceptron5][i] -= 1;

    }
    for(int i = 0; i < 256; i++)
    { 	
	int curPerceptron3 = hashghistpath(tid, i) % perceptronCount;
	for(int j = 0; j < 32; j++)
	{
		if (((thread_history >> (i*32 + j)) & 1) == taken)
      		  weightsTable[curPerceptron3][i * 32 + j + 1]    += 1;
      	  	else weightsTable[curPerceptron3][i * 32 + j + 1] -= 1;
		
	}
    } 




  }

  //UPDATE PAST PC TABLE
  pastPCTable.insert(pastPCTable.begin(), branch_addr);
  // only maintains the last H (globalPredictorSize) addresses in history
  if (pastPCTable.size() > (globalPredictorSize/2)) pastPCTable.pop_back();

  // Global history restore and update
  globalHistory[tid] = (globalHistory[tid] << 1) | taken;
  globalHistory[tid] &= historyRegisterMask;

 //update recency stack
 insert_recency(tid, branch_addr);
//theta_setting (tid, !squashed, abs(y_out_avg));
}
/*
void NeuroBP::theta_setting (ThreadID tid, bool correct, int a) {
		if (!correct) {
			tc++;
			if (tc >= speed) {
				theta++;
				tc = 0;
			}
		}
		if (correct && a < theta) {
			tc--;
			if (tc <= -speed) {
				theta--;
				tc = 0;
			}
		}
}
*/
//RECENCY POS
unsigned NeuroBP::hash_recency(ThreadID tid, int depth) {
			unsigned x = 0, k = 0;
			for (int i=0; i<depth; i++) {
				x ^= (!!(recency_stack[i] & 1)) << k;
				k++;
				k %= 32;
			}
			return x;	
	}
//RECENCY POS ENDS
unsigned NeuroBP::hash_recencypos(ThreadID tid, unsigned pc, int depth) {
			
for (int i=0; i<depth; i++) {
			if (recency_stack[i] == pc) return i;
		}

		// return last index in table on a miss

		return depth-1;


	}



//INSERT RECENCY
void NeuroBP::insert_recency (ThreadID tid, unsigned pc) {
		int i = 0;
		for (i=0; i<depth; i++) {
			if (recency_stack[i] == pc) break;
		}
		if (i == depth) {
			i = depth-1;
			recency_stack[i] = pc;
		}
		int j;
		unsigned b = recency_stack[i];
		for (j=i; j>=1; j--) recency_stack[j] = recency_stack[j-1];
		recency_stack[0] = b;
	}
//INSERT RECENCY ENDS

void
NeuroBP::squash(ThreadID tid, void *bp_history)
{
  BPHistory *history = static_cast<BPHistory *>(bp_history);

  // Restore global history to state prior to this branch.
  globalHistory[tid] = history->globalHistory;

  // Delete this BPHistory now that we're done with it.
  delete history;
}

unsigned
NeuroBP::getGHR(ThreadID tid, void *bp_history) const
{
  return static_cast<BPHistory *>(bp_history)->globalHistory;
}

NeuroBP*
NeuroBPParams::create()
{
  return new NeuroBP(this);
}
