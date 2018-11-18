package com.springapp.mvc;

import org.junit.Test;

import java.util.*;

/**
 * Created by fatty on 2018/8/11.
 */
public class kaoshi {
    public static void main(String[] args){
        Scanner sc=new Scanner(System.in);
        int total=sc.nextInt();
        int[] heapNum=new int[total];
        for(int i=0;i<total;i++){
            heapNum[i]=sc.nextInt();
        }
        int count=sc.nextInt();
        for(int i=0;i<count;i++){
            int nowSum=sc.nextInt();
            int j=0;
            int sum=0;
            while(sum<nowSum){
                sum+=heapNum[j];
                j++;
            }
            System.out.println(j);

        }
    }
}
