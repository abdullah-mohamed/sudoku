using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace soduku_simple_solver
{
    class find_unity 
    {
        void fill_forbid_row(int my_row)
        {
            for (i = 0; i < 9; i++)
            {
                if (soduku[my_row, i] != 0)
                {
                    row_forbidden[k] = soduku[my_row, i];       //put the value of the element in our forbidden matricies
                    k++;                                        //to avoid the loss of previous values                
                }
            }
            k = 0;
        }
        void fill_forbid_column(int my_column)
        {
            for (i = 0; i < 9; i++)
            {
                if (soduku[i, my_column] != 0)
                {
                    column_forbidden[k] = soduku[i, my_column]; //put the value of the element in our forbidden matricies
                    k++;                                        //to avoid the loss of previous values                
                }
            }
            k = 0;
        }
        int find_my_box(int my_row, int my_column)
        {
            int box = 0;
            if (my_row <= 2 && my_column <= 2)                     //we count from zero 
                box = 1;
            else if (my_row <= 2 && my_column <= 5 && my_column > 2)
                box = 2;
            else if (my_row <= 2 && my_column > 5)
                box = 3;
            else if (my_row <= 5 && my_row > 2 && my_column <= 2)
                box = 4;
            else if (my_row <= 5 && my_row > 2 && my_column > 2 && my_column <= 5)
                box = 5;
            else if (my_row <= 5 && my_row > 2 && my_column > 5)
                box = 6;
            else if (my_row > 5 && my_column <= 2)
                box = 7;
            else if (my_row > 5 && my_column > 2 && my_column <= 5)
                box = 8;
            else if (my_row > 5 && my_column < 5)
                box = 9;
            return box;
        }

        void fill_forbid_box(int my_box)
        {
            int row = 0, column = 0;
            if (my_box == 1 || my_box == 2 || my_box == 3)   // determine searching indicies
            {
                column = 0;
                if (my_box == 1)
                    row = 0;
                else if (my_box == 2)
                    row = 3;
                else
                    row = 6;
            }
            if (my_box == 4 || my_box == 5 || my_box == 6)   // determine searching indicies
            {
                column = 3;
                if (my_box == 4)
                    row = 0;
                else if (my_box == 5)
                    row = 3;
                else
                    row = 6;
            }
            if (my_box == 7 || my_box == 8 || my_box == 9)   // determine searching indicies
            {
                column = 6;
                if (my_box == 7)
                    row = 0;
                else if (my_box == 8)
                    row = 3;
                else
                    row = 6;
            }

            for (i = row; i < row + 3; i++)
            {
                for (j = column; j < column + 3; j++)
                {
                    if (soduku[i, j] != 0)
                    {
                        box_forbidden[k] = soduku[i, j];
                        k++;
                    }
                }
            }
            k = 0;
        }

        int elemenate()
        {
            int flag = 0;
            for (i = 0; i < 9; i++)                         // elemenate all unpossible values
            {
                for (j = 0; j < 9; j++)
                {
                    if (possible[i] == row_forbidden[j] || possible[i] == column_forbiden[j] || possible[i] == box_forbiden[j])
                        my_possible[i] = 0;
                }
            }
            for (i = 0; i < 9; i++)                         //check for an array with only one possible element as a solution
            {
                if (my_possible[i] != 0)
                {
                    k++;                                  //counter for number of possible values
                }
                if (k == 1)
                {
                    flag = 1;
                    for (i = 0; i < 9; i++)
                    {
                        if (my_possible[i] != 0)                 // we know for sure only one element exists
                            soduko[my_row, my_column] = my_possible[i];

                    }
                }

            }

            k = 0;
            return flag;

        }
        void refill()
        {
            for (i = 1; i < 9; i++)                        // refills my_possible vector with all possible values
            {
                my_possible[i - 1] = i;
            }
        }
    
    }
    
    class Program
    {
        int[] possible = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };        //all possible values in a single box
        int[] my_possible = new int[9] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        int[] row_forbidden = new int[9];                                //forbidden numbers for a certain indicies according to the elements in its rows
        int[] column_forbiden = new int[9];                             //forbidden numbers for a certain indicies according to the elements in its columns
        int[] box_forbiden = new int[9];                                //forbidden numbers for a certain indicies according to the elements in its box
        int k;                                                         //counter to add elements from the beginning of forbidden vectors
        int i, j;                                                      //loop_counters
        static void Main(string[] args)
        {
                                                                       //your soduku is entered where every space is given value of zero
            int[,] soduku = new int[9, 9] { {0,5,2,0,0,6,0,0,0} , {1,6,0,9,0,0,0,0,4},{0,4,9,8,0,3,6,2,0},{4,0,0,0,0,0,8,0,0},{0,8,3,2,0,1,5,9,0},{0,0,1,0,0,0,0,0,2},{0,9,7,3,0,5,2,4,0},{2,0,0,0,0,9,0,5,6},{0,0,0,1,0,0,9,7,0}};
            int i, j;                                                  //loop counters
                                                                       //we will find the missing square indicies 
            int[,] missing_items = new int[50, 3];
            int pointer1 = 0;                                         //to control the place of added items in the missing_items array
            for (i = 0; i < 9; i++)
            {
                for (j = 0; j < 9; j++)
                {
                    if (soduku[i, j] == 0) 
                    {
                        missing_items[pointer1, 0] = i;
                        missing_items[pointer1, 1] = j;
                        pointer1++;                        
                    }
                }
            }
            int my_row, my_column,my_box;                                  //the indicies of our missings will be put here consecutively
            for (i = 0; i < 50; i++)
            {
                my_row = missing_items[i,0];
                my_column = missing_items[i,1];
                fill_forbid_row(my_row);                           //find forbidden numbers for a certain indicies according to the elements in its rows
                fill_forbid_column(my_column);                     //find forbidden numbers for a certain indicies according to the elements in its columns
                my_box = find_my_box(my_row, my_column);           //find the box of the element
                fill_forbidden_box(my_box);                        //find forbidden numbers for a certain indicies according to the elements in its box
                flag2 = elemenate();
                refill();
                if (Flag2 == 1)                                   // if we found a solution we need to start rebuilding our possibilities
                    i = 0;
 
            }            
            Console.ReadLine();
        }
                                                                   //functions
        
    }
}
