% McGrattan
% 6-22-2023
% NIST_NRC_Parallel_Panels.m
%
% This script creates several different kinds of plots for NIST_NRC_Parallel_Panels cases.

clear all
close all

outdir = '../../../out/NIST_NRC_Parallel_Panels/';
expdir = '../../../exp/Submodules/macfp-db/Fire_Growth/NIST_Parallel_Panel/Experimental_Data/';
pltdir = '../../Manuals/FDS_Validation_Guide/SCRIPT_FIGURES/NIST_NRC_Parallel_Panels/';

plot_style

z = [10 20 30 50 75 100 140 180 220];
zm = linspace(1,243,50);
E = importdata([expdir,'PMMA_heatflux.csv'],',',2);
M = importdata([outdir,'PMMA_60_kW_1_cm_devc.csv'],',',2);

for i=[1 2 3 5 8 9 10]
   qdot{i} = E.data(i,2:10);
   err{i}  = E.data(i,11:19);
   errorbar(qdot{i},z,err{i},"horizontal","o")
   hold on
end

for i=[6 7 8 9 10 11 15]
   qdotm{i} = M.data(i,2:51);
   plot(qdotm{i},zm)
   hold on
end
   
xlabel('Heat Flux (kW/m²)','FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('Height (cm)','FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
legend('120 kW','200 kW','300 kW','500 kW','1500 kW','2000 kW','2800 kW','Location','SouthEast','FontSize',10)
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])
set(gca,'FontName',Font_Name)
set(gca,'FontSize',Title_Font_Size)
axis([0 150 0 250])

Git_Filename = [outdir,'PMMA_60_kW_1_cm_git.txt'];
addverstr(gca,Git_Filename,'linear')

set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
print(gcf,'-dpdf',[pltdir,'PMMA_Heat_Flux'])

hold off

clear z E M qdot

z = [20 40 60 80];
E = importdata([expdir,'Burner_HF_Centerline_multi-layer.csv'],',',2);
M1 = importdata([outdir,'Marinite_60_kW_1_cm_devc.csv'],',',2);
M2 = importdata([outdir,'Marinite_60_kW_2_cm_devc.csv'],',',2);

co = [1 0 0; 0 1 0; 0 1 1;0 0 0];
set(0,'DefaultAxesColorOrder',co)

for i=[1 2 3 4]
   qdot{i} = E.data(i,3:6);
   plot(qdot{i},z,'o')
   hold on
end
set(0,'DefaultAxesColorOrder',co)
xticks([0 10 20 30 40 50 60 70 80])
yticks([0 20 40 60 80 100 120 140 160 180])

for i=[15 21 31 41]
   plot(M1.data(i,2:51),zm)
   hold on
end
set(0,'DefaultAxesColorOrder',co)
for i=[15 21 31 41]
   plot(M2.data(i,2:51),zm,'--')
   hold on
end

xlabel('Heat Flux (kW/m²)','FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('Height (cm)','FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
legend('Exp 20 s','Exp 40 s','Exp 60 s','Exp 80 s','FDS 1 cm','FDS 1 cm','FDS 1 cm','FDS 1 cm','FDS 2 cm','FDS 2 cm','FDS 2 cm','FDS 2 cm','Location','NorthEast','FontSize',10)
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])
set(gca,'FontName',Font_Name)
set(gca,'FontSize',Title_Font_Size)
axis([0 80 0 180])

Git_Filename = [outdir,'PMMA_60_kW_1_cm_git.txt'];
addverstr(gca,Git_Filename,'linear')

set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
print(gcf,'-dpdf',[pltdir,'Marinite_Heat_Flux'])

hold off

