/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package choco_graphcoloring;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import org.chocosolver.solver.Model;
import org.chocosolver.solver.variables.IntVar;
import org.chocosolver.solver.Solver;

/**
 *
 * @author Marzieh
 */
public class Choco_GraphColoring {

    /**
     * @param args the command line arguments
     */
    public static void main(final String... args) throws FileNotFoundException {

        final Scanner scanner = new Scanner(new File("C:\\graph-coloring-4.txt"));
        int node_num = scanner.nextInt();
        int edge_num = scanner.nextInt();
        int k = scanner.nextInt();
        ArrayList<ArrayList<Integer>> x = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < edge_num; i++) {
            x.add(new ArrayList<Integer>());
            scanner.next();
            for (int j = 0; j < 2; j++) {
                x.get(i).add(j, scanner.nextInt());
            }
        }

//           //showing the content of the input file      
//      for(int i = 0; i < x.size(); i++){
//          for(int j = 0; j < x.get(i).size(); j++){
//              System.out.print(x.get(i).get(j));
//              System.out.print(' ');
//          }
//          System.out.println();
//      }
        //creating the adjacency matrix
        Boolean[][] adjacency_matrix = new Boolean[node_num][node_num];
        for (int i = 0; i < node_num; i++) {
            for (int j = 0; j < node_num; j++) {
                adjacency_matrix[i][j] = false;
            }
        }
        for (int i = 0; i < node_num; i++) {
            for (int j = 0; j < edge_num; j++) {
                if (x.get(j).get(1) == i + 1) {
                    adjacency_matrix[i][x.get(j).get(0) - 1] = true;
                }
                if (x.get(j).get(0) == i + 1) {
                    adjacency_matrix[i][x.get(j).get(1) - 1] = true;
                }
            }
        }

//           //showing the content of the adjacency matrix
//      for(int i = 0; i < node_num; i++){
//          for(int j = 0; j < node_num; j++){
//              System.out.print(adjacency_matrix[i][j]);
//              System.out.print(' ');
//          }
//          System.out.println();
//      }
        Model model = new Model("GraphColoring");
        IntVar[] nodes = model.intVarArray("nodes", node_num, 1, k);

        for (int i = 0; i < node_num; i++) {
            for (int j = 0; j < node_num; j++) {
                if (adjacency_matrix[i][j] == true) {
                    model.allDifferent(nodes[i], nodes[j]).post();
                }
            }
        }

        //solver
        Solver solver = model.getSolver();
        if (solver.solve()) {
            System.out.println(1);
            for (int i = 0; i < node_num; i++) {
                System.out.printf("%d %d", i + 1, nodes[i].getValue());
                System.out.println();
            }
        } else {
            System.out.println(0);
        }
        
    }//end of main
}
