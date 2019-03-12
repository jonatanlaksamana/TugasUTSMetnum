clear all
close all
clf
clc
 %generate data
fileID = fopen('data25.txt','r');
A = fscanf(fileID,'%f %f',[2 Inf]);
%insert kedalam matrix
x = A(1,:);
y = A(2,:);

min = realmax;
dimensi = 0;

for i=1:5
reg = fPolyFit(x,y,i);
ypred = polyval(reg,x);
rmse = sqrt(sum((y-ypred).^2)/100);
    if(rmse<min)
         min = rmse;
         dimensi = i;
    end
end
fprintf("dimensi terbaik adalah dimensi drajat");
disp(dimensi);
fprintf("dengan nilai rmse terendah :");
disp(min);



function p = fPolyFit(x, y, n)
% buat Vandermonde matrix:
x = x(:);
%jumlah colom di tambah 2 untuk menampung hasil  dan bo (koef tanpa
%variable)
%buat matrix kosong isi nya satu semua
V = ones(length(x), n + 2);
%buat matrix 
for j = n:-1:1
   V(:, j) = V(:, j + 1) .* x;
end
%isi variable terakhir dengan nilai y 
V(:,end) = y;
%gaus jordan elimination 
R = rref(V);
% Solve least squares problem:
p      = R(:,end);
% Equivalent: (V \ y)'
end