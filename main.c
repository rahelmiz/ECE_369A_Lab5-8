
#include <stdio.h>
int position_1D(int x,int y,int width){
    //x: row number in the 2d array
    //y: column number in the 2d array
    //width: number of columns in the 2d array
    int position_1D = (x-1)*width + y;
    return position_1D;
}

void populate_array(int rows, int cols, int array[rows][cols]){
    //populates the array, each element is one more than the previous
    for (int i = 1; i < rows+1; ++ i){
        for (int j = 1; j < cols+1; ++ j){
            array[i][j] = (i-1)*rows + j;
//printf("%d ", array[i][j]);
        }
    }
}
void print_array(int rows, int cols, int array[rows][cols]){
    //populates the array, each element is one more than the previous
    for (int i = 0; i < rows; ++ i){
        for (int j = 0; j < cols; ++ j){
            printf("%d ", array[i+1][j+1]);
        }
        printf("\n");
    }
}

int main(int argc, const char * argv[]) {
    const int rows = 16;
    const int cols = 16;
    int arr[rows][cols];

    //populate_array(rows, cols, arr);
    //print_array(rows, cols, arr);
    int pos1D = position_1D(4,1, rows);
    printf("%d ", pos1D);
    return 0;
}
