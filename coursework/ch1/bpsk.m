%%
 %  File: bpsk.m
 % 
 %  Author: Thomas Kost
 %  
 %  Date: 26 January 2022
 %  
 %  @brief bpsk signal creator
 %
 
 function value = bpsk(p,N)
   value = -sign(rand([N,1])-p);