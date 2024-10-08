/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MaxSAT_RandomRestartHillClimbing;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;
import java.lang.Math;
import java.util.Arrays;

/**
 *
 * @author Marzieh
 */
public class MaxSAT_RandomRestartHillClimbing {

    /**
     * @param args the command line arguments
     */
    public static void main(final String... args) throws FileNotFoundException {

        final Scanner scanner = new Scanner(new File("C:\\max-sat-20-90.txt"));
        int var_num = scanner.nextInt();
        int clause_num = scanner.nextInt();
        ArrayList<ArrayList<Integer>> x = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < clause_num; i++) {
            x.add(new ArrayList<Integer>());
            int y = scanner.nextInt();
            for (int j = 0; y != 0; j++) {
                x.get(i).add(j, y);
                y = scanner.nextInt();
            }
        }

//   showing the content of the input file      
//      for(int i = 0; i < x.size(); i++){
//          for(int j = 0; j < x.get(i).size(); j++){
//              System.out.print(x.get(i).get(j));
//              System.out.print(' ');
//          }
//          System.out.println();
//      }
        int best = 0;
        Boolean[] best_val = new Boolean[var_num];
        final int max = 1000;
        Random rb = new Random();
        for (int i = 0; i < max; i++) {
            boolean local = false;
            //selecting a current point
            Boolean[] current = new Boolean[var_num];
            for (int k = 0; k < var_num; k++) {
                current[k] = rb.nextBoolean();
            }

            //evaluating the current point
            int current_satidfied = 0;
            for (int m = 0; m < x.size(); m++) {
                boolean flag = false;
                for (int k = 0; k < x.get(m).size(); k++) {
                    int y = x.get(m).get(k);
                    if (y > 0) {
                        if (current[y - 1] == true) {
                            flag = true;
                            break;
                        }
                    } else if (y < 0) {
                        y = Math.abs(y);
                        if (current[y - 1] == false) {
                            flag = true;
                            break;
                        }
                    }
                }
                if (flag == true) {
                    current_satidfied++;
                }
            }

            //the inner loop of algorithm
            while (local == false) {
                //creating neighbors
                Boolean[][] neighbors = new Boolean[var_num][var_num];
                for (int j = 0; j < var_num; j++) {
                    for (int k = 0; k < var_num; k++) {
                        if (j == k) {
                            if (current[k] == true) {
                                neighbors[j][k] = false;
                            } else {
                                neighbors[j][k] = true;
                            }
                        } else {
                            neighbors[j][k] = current[k];
                        }
                    }
                }

                //evaluating neigbors
                int[] neighbor_val = new int[var_num];
                for (int j = 0; j < var_num; j++) {
                    neighbor_val[j] = 0;
                    for (int m = 0; m < x.size(); m++) {
                        boolean flag = false;
                        for (int k = 0; k < x.get(m).size(); k++) {
                            int y = x.get(m).get(k);
                            if (y > 0) {
                                if (neighbors[j][y - 1] == true) {
                                    flag = true;
                                    break;
                                }
                            } else if (y < 0) {
                                y = Math.abs(y);
                                if (neighbors[j][y - 1] == false) {
                                    flag = true;
                                    break;
                                }
                            }
                        }
                        if (flag == true) {
                            neighbor_val[j]++;
                        }
                    }
                }

                //having a copy from array neighbor_val before sorting it
                int[] not_sorted_neighbor_val = new int[var_num];
                for(int j=0;j<var_num;j++){
                    not_sorted_neighbor_val[j]=neighbor_val[j];
                }
                
                //selecting the best value between neighbors
                int best_neighbor_val = 0;
                int best_neighbor = 0;          
                Arrays.sort(neighbor_val);
                best_neighbor_val = neighbor_val[var_num - 1];
                for (int j = 0; j < var_num; j++) {
                    if (not_sorted_neighbor_val[j] == best_neighbor_val) {
                        best_neighbor = j;
                        break;
                    }
                }

                //comparison between current and the best neighbor 
                if (best_neighbor_val > current_satidfied) {
                    for (int k = 0; k < var_num; k++) {
                        current[k] = neighbors[best_neighbor][k];
                    }
                    current_satidfied = best_neighbor_val;
                } else {
                    local = true;
                }
            }
            //best value ever
            if (current_satidfied > best) {
                best = current_satidfied;
                for (int k = 0; k < var_num; k++) {
                    best_val[k] = current[k];
                }
            }
        }

        //output
        System.out.println(best);
        for (int k = 0; k < var_num; k++) {
            if (best_val[k] == true) {
                System.out.println(1);
            } else {
                System.out.println(0);
            }
        }

    }

}
