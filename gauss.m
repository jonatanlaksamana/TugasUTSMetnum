%___________________________________
% Gauss Jordan Implementation
% By Khaled Sharif
%
% Description:
% This function will take a matrix designed to be used by the
% Gauss-Jordan algorithm and solve it, returning a transposed
% version   of the  last  column in the  ending  matrix which 
% represents the solution to the unknown variables.
%
% Input:
% The function  takes  one matrix of n by n+1, where n equals  
% the number of unknown variables.  Each row  represents  the 
% coefficients of the variables in each equation and the last
% column  contains the  constants on the right  hand side  of
% each equation.
%
% Output:
% The  function  will    return a column vector  representing
% the solution to each variable in order of appearance in the
% given matrix. 
%
% Sample Input:
% x = [1 3 1 10; 1 -2 -1 -6; 2 1 2 10];
% gauss(x)
%
% Sample Output:
% ans =
%
%    1.0000    2.0000    3.0000
%
%___________________________________

function [y] = gauss_jordan (x)    
    for n = 1:(length(x)-1)
        % Step 1: make the row N's Nth term 1 by dividing 
        % the whole row by it
        A = x(n,:);
        A = A/A(n);
        x(n,:) = A;
        
        % Step 2: for every other row add to it -1 * that rows Nth term *
        % the Nth row
        for k = 1:(length(x)-1)
            if n~=k
                x(k,:) = A*(-1*x(k,n)) + x(k,:);
            end
        end
    end
    
    y = x(:,length(x))';
end