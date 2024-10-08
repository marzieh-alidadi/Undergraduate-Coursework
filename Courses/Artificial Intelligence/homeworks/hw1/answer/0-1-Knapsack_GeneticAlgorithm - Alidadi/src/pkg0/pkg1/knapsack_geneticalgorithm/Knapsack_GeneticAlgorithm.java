/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkg0.pkg1.knapsack_geneticalgorithm;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

/**
 *
 * @author Marzieh
 */
public class Knapsack_GeneticAlgorithm {

    /**
     * @param args the command line arguments
     */
    public static void main(final String... args) throws FileNotFoundException {

        final Scanner scanner = new Scanner(new File("C:\\knapsack-20.txt"));
        int object_num = scanner.nextInt();
        int knapsack_weight = scanner.nextInt();
        ArrayList<ArrayList<Integer>> x = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < object_num; i++) {
            x.add(new ArrayList<Integer>());
            for (int j = 0; j < 2; j++) {
                x.get(i).add(j, scanner.nextInt());
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
        Random rb = new Random();
        final int k = 9;

        int[] not_sorted_current_population_fitness = new int[k];

        //selecting a current population
        Boolean[][] current_population = new Boolean[k][object_num];
        for (int i = 0; i < k; i++) {
            for (int j = 0; j < object_num; j++) {
                current_population[i][j] = rb.nextBoolean();
            }
        }

        //validating and evaluating current population
        int[] current_population_fitness = new int[k];
        int[] current_population_weight = new int[k];
        for (int i = 0; i < k; i++) {
            int sum_value = 0;
            int sum_weight = 0;
            int flag = 0;
            for (int j = 0; j < object_num; j++) {
                if (current_population[i][j] == true) {
                    sum_value += x.get(j).get(0);
                    sum_weight += x.get(j).get(1);
                    if (sum_weight > knapsack_weight) {
                        current_population_fitness[i] = sum_value - x.get(j).get(0);
                        current_population_weight[i] = sum_weight - x.get(j).get(1);
                        for (int m = j; m < object_num; m++) {
                            current_population[i][m] = false;
                            flag = 1;
                        }
                    } else {
                        current_population_fitness[i] = sum_value;
                        current_population_weight[i] = sum_weight;
                    }
                }
                if (flag == 1) {
                    break;
                }
            }
        }

        /*
        for (int i = 0; i < k; i++) {
            System.out.println(current_population_fitness[i]);
        }
        System.out.println('\n');
         */
        //sum of current population fitness
        int current_sum_fitness = 0;
        for (int i = 0; i < k; i++) {
            current_sum_fitness += current_population_fitness[i];
        }

        int best_fitness = 0;
        int best_weight = 0;
        boolean[] best_individual = new boolean[object_num];

        //the main loop of algorithm
        while (true) {

            //selectiong the best inidividual
            for (int i = 0; i < k; i++) {
                if (current_population_fitness[i] > best_fitness) {
                    best_fitness = current_population_fitness[i];
                    best_weight = current_population_weight[i];
                    for (int j = 0; j < object_num; j++) {
                        best_individual[j] = current_population[i][j];
                    }
                }
            }

            //having a copy from array current_population_fitness before sorting it
            for (int j = 0; j < k; j++) {
                not_sorted_current_population_fitness[j] = current_population_fitness[j];
            }

            //parent selection
            Arrays.sort(current_population_fitness);
            /*
        for (int i = 0; i < k; i++) {
            System.out.println(current_population_fitness[i]);
        }
        System.out.println('\n');
             */
            int freq[] = new int[k];
            freq[0] = 1;
            for (int i = 1; i < k; i++) {
                freq[i] = freq[i - 1] + 1;
            }
            int k1 = k / 2;
            int parents_value[] = new int[k1];
            for (int i = 0; i < k1; i++) {
                if (i == 0) {
                    parents_value[0] = myRand(current_population_fitness, freq, k);
                } else {
                    int y;
                    int flag;
                    do {
                        flag = 0;
                        y = myRand(current_population_fitness, freq, k);
                        for (int j = 0; j < i; j++) {
                            if (y == parents_value[j]) {
                                flag = 1;
                                break;
                            }
                        }
                    } while (flag == 1);
                    parents_value[i] = y;
                }
            }
            /*
        for (int i = 0; i < k1; i++) {
            System.out.println(parents_value[i]);
        }
        System.out.println('\n');
             */
            int parents[] = new int[k1];
            for (int j = 0; j < k1; j++) {
                for (int z = 0; z < k; z++) {
                    if (not_sorted_current_population_fitness[z] == parents_value[j]) {
                        parents[j] = z;
                        break;
                    }
                }
            }

            //crossover
            int children_number = (k / 3) * 4;
            Boolean[][] children = new Boolean[children_number][object_num];
            for (int i = 0; i < children_number - 1; i = i + 2) {
                int y1 = parents[(int) (Math.random() * k1)];//index of paretnt 1 in population
                int y2 = parents[(int) (Math.random() * k1)];//index of paretnt 2 in population
                int cross_point = (int) (Math.random() * object_num - 1) + 1;
                for (int j = 0; j < object_num; j++) {
                    if (j < cross_point) {
                        children[i][j] = current_population[y1][j];
                        children[(i) + 1][j] = current_population[y2][j];
                    } else {
                        children[i][j] = current_population[y2][j];
                        children[(i) + 1][j] = current_population[y1][j];
                    }
                }
            }

            //mutation (with 25% probability)
            int mutation_probability_size = object_num * 4;
            int[] mutation_probability = new int[mutation_probability_size];
            for (int i = 0; i < mutation_probability_size - 3; i = i + 4) {
                mutation_probability[i] = -1;
                mutation_probability[i + 1] = -1;
                mutation_probability[i + 2] = -1;
                mutation_probability[i + 3] = i / 4;
            }
            for (int i = 0; i < children_number; i++) {
                int mutation_point = (int) (Math.random() * mutation_probability_size);
                if (mutation_probability[mutation_point] != -1) {
                    int child_index = mutation_probability[mutation_point];
                    if (children[i][child_index] == true) {
                        children[i][child_index] = false;
                    } else {
                        children[i][child_index] = true;
                    }
                }
            }

            //validating and evaluating children
            int[] children_fitness = new int[children_number];
            int[] children_weight = new int[children_number];
            for (int i = 0; i < children_number; i++) {
                int sum_value = 0;
                int sum_weight = 0;
                int flag = 0;
                for (int j = 0; j < object_num; j++) {
                    if (children[i][j] == true) {
                        sum_value += x.get(j).get(0);
                        sum_weight += x.get(j).get(1);
                        if (sum_weight > knapsack_weight) {
                            children_fitness[i] = sum_value - x.get(j).get(0);
                            children_weight[i] = sum_weight - x.get(j).get(1);
                            for (int m = j; m < object_num; m++) {
                                children[i][m] = false;
                                flag = 1;
                            }
                        } else {
                            children_fitness[i] = sum_value;
                            children_weight[i] = sum_weight;
                        }
                    }
                    if (flag == 1) {
                        break;
                    }
                }
            }

            //having a copy from array children_fitness before sorting it
            int[] not_sorted_children_fitness = new int[children_number];
            for (int j = 0; j < children_number; j++) {
                not_sorted_children_fitness[j] = children_fitness[j];
            }

            //selecting the best k children
            int[] best_children_fitness = new int[k];
            int[] best_children = new int[k];
            Arrays.sort(children_fitness);
            for (int i = 0; i < k; i++) {
                best_children_fitness[i] = children_fitness[i];
            }
            for (int i = 0; i < k; i++) {
                for (int j = 0; j < children_number; j++) {
                    if (best_children_fitness[i] == not_sorted_children_fitness[j]) {
                        best_children[i] = j;
                        break;
                    }
                }
            }

            //sum of children fitness
            int best_children_sum_fitness = 0;
            for (int i = 0; i < k; i++) {
                best_children_sum_fitness += best_children_fitness[i];
            }

            //comparison between current and the best childran 
            if (best_children_sum_fitness >= current_sum_fitness) {
                current_sum_fitness = best_children_sum_fitness;
                for (int j = 0; j < k; j++) {
                    current_population_fitness[j] = children_fitness[best_children[j]];
                    current_population_weight[j] = children_weight[best_children[j]];
                    for (int z = 0; z < object_num; z++) {
                        current_population[j][z] = children[best_children[j]][z];
                    }
                }
            } else {
                break;
            }
        }

        //output
        System.out.print(best_fitness);
        System.out.print(' ');
        System.out.println(best_weight);
        for (int i = 0; i < object_num; i++) {
            if (best_individual[i] == true) {
                System.out.println(1);
            } else {
                System.out.println(0);
            }
        }

    }//end of main

    //the fallowing 2 functions are used to generate random numbers with special probability
// Utility function to find ceiling of r in arr[l..h]  
    static int findCeil(int arr[], int r, int l, int h) {
        int mid;
        while (l < h) {
            mid = l + ((h - l) >> 1); // Same as mid = (l+h)/2  
            if (r > arr[mid]) {
                l = mid + 1;
            } else {
                h = mid;
            }
        }
        return (arr[l] >= r) ? l : -1;
    }

    static int myRand(int arr[], int freq[], int n) {
        // Create and fill prefix array  
        int prefix[] = new int[n], i;
        prefix[0] = freq[0];
        for (i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + freq[i];
        }

        // prefix[n-1] is sum of all frequencies. 
        // Generate a random number with  
        // value from 1 to this sum  
        int r = ((int) (Math.random() * (323567)) % prefix[n - 1]) + 1;

        // Find index of ceiling of r in prefix arrat  
        int indexc = findCeil(prefix, r, 0, n - 1);
        return arr[indexc];
    }

}
