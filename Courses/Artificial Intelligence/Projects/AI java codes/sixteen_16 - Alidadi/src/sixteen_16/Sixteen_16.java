/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sixteen_16;

import java.io.InputStream;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

/**
 *
 * @author Marzieh
 */
public class Sixteen_16 {

    /**
     * @param args the command line arguments
     */
    public static Scanner in = new Scanner(System.in);

    static int[] button = new int[10];
    static int[] explored = new int[10000];

    public static void main(String[] args) {

        int L, U, R, min_press;

        for (int j = 1; j <= 100; j++) {

            //get the values of each case
            L = in.nextInt();
            U = in.nextInt();
            R = in.nextInt();
            if (L == 0 && U == 0 && R == 0) {
                break;
            }
            for (int i = 0; i < R; i++) {
                button[i] = in.nextInt();
            }

            min_press = BFS(L, U, R);

            System.out.print("Case ");
            System.out.print(j);
            System.out.print(": ");
            if (min_press == -1) {
                System.out.println("Permanently Locked");
            } else {
                System.out.println(min_press);
            }
        
        }

    }//end of main

    static int BFS(int L, int U, int R) {

        int temp1, temp2;

        for (int i = 0; i < 10000; i++) {
            explored[i] = -1;
        }

        Queue<Integer> frontier = new LinkedList<>();
        frontier.add(L);
        explored[L] = 0;

        while (!frontier.isEmpty()) {
            temp1 = frontier.remove();
            for (int i = 0; i < R; i++) {
                temp2 = (temp1 + button[i]) % 10000;
                if (explored[temp2] != -1) {
                    continue;
                }
                explored[temp2] = explored[temp1] + 1;
                if (temp2 == U) {
                    return explored[temp2];
                }
                frontier.add(temp2);
            }
        }

        return -1;
    }

}
