ORIGIN 0
SEGMENT CodeSegment1:

START:
    LEA	 R0, DataSegment
    ADD	 R1, R1, 12
    ADD	 R3, R3, -1
Loop1:
	ADD  R1, R1, -1
	ADD  R3, R3, -1
	ADD  R1, R1, 1
	ADD  R3, R3, 1
	ADD  R1, R1, R3
	BRp Loop1
	LDR	 R2, R0, Initial_1
	AND	 R4, R4, 0
	AND  R5, R5, 0
	ADD  R4, R4, 1
	ADD  R5, R5, 1
	LDI  R2, R0, Counters_Mispredict
	LDI  R3, R0, Counters_TotalBranch
HALT:
  BRnzp HALT

SEGMENT DataSegment:
Initial_1: DATA2 4x600D
Initial_2: DATA2 4xBadd
Counters_Mispredict:  DATA2 4xFFF2
Counters_TotalBranch: DATA2 4xFFF0
