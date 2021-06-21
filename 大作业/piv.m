%
%  piv.m
%  大作业
%
%  Created by Yuan Leiqi (袁磊祺) on 2021/6/20.
%

clear;clc;close all;
set(0,'defaultlinelinewidth',3)
set(0,'defaultaxeslinewidth',2);
set(0,'defaultaxesfontsize',28);
set(0,'defaulttextfontsize',28);
set(0,'DefaultLineMarkerSize',2);
set(0,'Defaultaxesfontname','Times New Roman');
addpath('../../data/');
% set(gcf,'unit','centimeters','position',[20 20 20 20])
% figure(); box on;
% plot(x/D,W0_axi,'-');
% xlabel('$x/D$','interpreter','latex');
% ylabel('$U_0$','interpreter','latex');

% saveas(gcf,'Re_80_U0_axi','epsc')


I1 = imread('001.tif');
I2 = imread('002.tif');

I1 = I1(1:100, 1:200);
I2 = I2(1:100, 1:200);

width = 20; % the width of interrogation areas
d = ceil(width/2);
l = 10; % search interrogation areas no longer than l

[m, n] = size(I1);

vec = zeros(m-2*l-2*d-1, n-2*l-2*d-1, 2);
corre = zeros(2*l+1, 2*l+1);

for i = l+d+1:m-d-l-1
	for j = l+d+1:n-d-l-1
		for p = -l:l
			for q = -l:l
				corre(p+l+1, q+l+1) = corr2(I1(i-d:i+d, j-d:j+d), I2(i+p-d:i+p+d, j+q-d:j+q+d));
			end
		end
		% surf(corre)
		[M, index] = max(corre);
		[M1, index_j] = max(M);
		index_i = index(index_j);
		vec(i-l-d, j-l-d, 2) = index_i-l-1;
		vec(i-l-d, j-l-d, 1) = index_j-l-1;
	end
end

%%
figure(); box on;
quiver(vec(:, :, 1), vec(:, :, 2))
% set(gcf,'unit','centimeters','position',[20 20 20 20])
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');

saveas(gcf,'Velocity','epsc')


