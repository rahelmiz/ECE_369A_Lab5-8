
#include <stdio.h>

int return1, return2;
struct pos_2d{
    int row;
    int col;
};

int position_1D(int x,int y,int width){
    //x: row number in the 2d array
    //y: column number in the 2d array
    //width: number of columns in the 2d array
    int position_1D = (x)*width + y;
    return position_1D;
}

int get_row(int pos_1d, int width){
//return the row # of the 2D array,
//given the mapped 1D position, and width of the 2D array
    unsigned int res = pos_1d;
    unsigned int count = 0;
    while (!(res < width)){
        res = res - width;
        //printf("%d ",res);
        count +=1;
    }
    return count;
}

int get_col(int pos_1d, int width){
//return the column # of the 2D array,
//given the mapped 1D position, and width of the 2D array
    unsigned int res = pos_1d;
    while (!(res < width)){
        res = res - width;
        //printf("%d ",res);
    }
    return res;
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
    //int pos1D = position_1D(4,1, rows);
    
    int row = get_row(21, 8);
    int col = get_col(21, 8);
    printf("row: ");
    printf("%d\n", row);
    
    printf("col : ");
    printf("%d\n", col);
    return 0;
}
