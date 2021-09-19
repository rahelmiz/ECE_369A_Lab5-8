#define _CRT_SECURE_NO_WARNINGS
/*
This program is a proof-of-concept for the window-search algorithm shown during class,
where an i x j frame holds values, and we must take a look at all possible windows of size m x n. 
Furthermore, this should be done in a diagonal pattern.
Windows and frames may be square or rectangle, and a window will never be larger than a frame in any of their
corresponding dimensions. 

The first step in this program was having an indicator that moved through each cell of the frame
diagonally, without taking into account window size. This "marker" moves diagnally until reaching either
the horizontal or vertical boundaries. 

Once this logic is implemented, the same algorithm is used but with an offset which accounts for window size,
essentially creating a version of step one with new sizes.

The logic used involved noting the pattern that was created.
The direction of the next index to explore depended on whether the sum of the current indexes
was even or odd AND whether the current indexes where at the edge of the frame.

Using these two key facts, the direction the search should go to fulfill the diagonal pattern
can be deduced with no need of knowing the prior direction.

Finally, special cases where implemented when the explorable area was a single row/column array\
This portion of the code takes care of the exceptions when determining the next direction
as well as providing fast frame exploration for these specia cases.
*/

#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include<assert.h>

//Function that takes as an input a window dimensions ixj, and frame dimensions mxn. The function explores
//every possible window within the frame. Does not wrap around for the edges.
void iterate_through_frame(int i, int j, int m, int n) {
	//We assert our window size is valid
	assert(i <= m);
	assert(j <= n);

	//We adjust the searches necessary according to the size of the window and frame
	//For example, if our window is 3x4 and our frame 6x7, with indices starting at 0,
	//We'd only need to explore columns 0,1,2,3, as our window extends 4 columns
	//Meaning we'd be exploring 0 through 3, 1 through 4, 2 through 5, and 3 through 6
	//Same with the rows
	int rowLimit = m - i;
	int columnLimit = n - j;
	bool finished = false;



	//We start at the top left corner of the frame
	int currentRow = 0, currentColumn = 0; //Which indexes is the top left corner of our window currently in
	int entrySum; //Sum of current column and current row. Important as it determines behavior
	int sumMod2; //Whether the sum is even or odd

	//Fast case 1: A single row array to explore. This includes being both a single row and column as well
	if (i == m) {
		//Iterate through each column in the row array
		for (int x = 0; x <= (n - j); x++) {
			printf("Exploring indexes %d,%d\n", currentRow, currentColumn);
			currentColumn++;
		}
		finished = true;
	}

	//Fast case 2: A single column array to explore.
	else if (j == n) {
		//Iterate through each column in the row array
		for (int x = 0; x <= (m - i); x++) {
			printf("Exploring indexes %d,%d\n", currentRow, currentColumn);
			currentRow++;
		}
		finished = true;
	}

	//Non-special scenarios
	else {
		while (!finished) {
			printf("Exploring indexes %d,%d\n", currentRow, currentColumn);
			entrySum = currentColumn + currentRow;
			sumMod2 = entrySum % 2;
			
			//First scenario, if we are located at the rightmost column
			if (currentColumn == columnLimit) {
				//If sum is even, go one down. If odd, go down-left
				switch (sumMod2) { 
				case 0:
					currentRow++;
					break;
				
				case 1:
					currentRow++;
					currentColumn--;
				}
			}

			//Second scenario, if at bottom row
			else if (currentRow == rowLimit) {
				//If sum is even, go top-right. If odd, go right
				switch (sumMod2) {
				case 0:
					currentRow--;
					currentColumn++;
					break;

				case 1:
					currentColumn++;
				}
			}

			//Third scenario, if at top row
			else if (currentRow == 0) {
				//If sum is even, go right. If odd, go down-left
				switch (sumMod2) {
				case 0:
					currentColumn++;
					break;

				case 1:
					currentRow++;
					currentColumn--;
				}
			}

			//Fourth scenario, if at leftmost column
			else if (currentColumn == 0) {
				//If sum is even, go top-right. If odd, go down
				switch (sumMod2) {
				case 0:
					currentColumn++;
					currentRow--;
					break;

				case 1:
					currentRow++;
				}
			}

			//Fifth, a non-border scenario
			else {
				//If sum is even, go top-right. If odd, go down-left
				switch (sumMod2) {
				case 0:
					currentColumn++;
					currentRow--;
					break;

				case 1:
					currentRow++;
					currentColumn--;
				}
			}

			//Check whether the bottom-right corner was reached and end if so
			if (currentRow > rowLimit || currentColumn > columnLimit) {
				finished = true;
			}
		}
	}

	printf("All windows have been explored.\n\n\n");
}

int main(void) {
	//Set the array sizes. Window is ixj and frame is m x n;
	int i, j;
	int m, n;

	//Test 1, testing version 1 which moves a single marker through a every element in the frame
	// In other words, the size of the window is 1x1
	//Testing a frame size 4x4
	printf("---------------------------------------------\n");
	printf("Test 1: Window 1x1, frame 4x4.\n");
	i = 1;
	j = 1;
	m = 4;
	n = 4;
	iterate_through_frame(i, j, m, n);

	//Test 2. Window 1x1, frame 1x1
	printf("---------------------------------------------\n");
	printf("Test 2: Window 1x1, frame 1x1.\n");
	i = 1;
	j = 1;
	m = 1;
	n = 1;
	iterate_through_frame(i, j, m, n);

	//Test 3. Window 1x1, frame 1x6
	printf("---------------------------------------------\n");
	printf("Test 3: Window 1x1, frame 1x6.\n");
	i = 1;
	j = 1;
	m = 1;
	n = 6;
	iterate_through_frame(i, j, m, n);

	//Test 4. Window 1x1, frame 8x1
	printf("---------------------------------------------\n");
	printf("Test 4: Window 1x1, frame 8x1.\n");
	i = 1;
	j = 1;
	m = 8;
	n = 1;
	iterate_through_frame(i, j, m, n);

	//Test 5: Window 3x3, frame 3x9.
	printf("---------------------------------------------\n");
	printf("Test 5: Window 3x3, frame 3x9.\n");
	i = 3;
	j = 3;
	m = 3;
	n = 9;
	iterate_through_frame(i, j, m, n);

	//Test 6: Window 2x5, frame 4x7.
	printf("---------------------------------------------\n");
	printf("Test 6: Window 2x5, frame 4x7.\n");
	i = 2;
	j = 5;
	m = 4;
	n = 7;
	iterate_through_frame(i, j, m, n);

	//Test 7: Window 16x14, frame 20x32.
	printf("---------------------------------------------\n");
	printf("Test 7: Window 16x14, frame 20x32.\n");
	i = 16;
	j = 14;
	m = 20;
	n = 32;
	iterate_through_frame(i, j, m, n);

	

}