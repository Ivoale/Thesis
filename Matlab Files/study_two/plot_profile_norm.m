function plotted = plot_profile_norm(sensor,trials,DoSaveFile)
% Plot normalised raw data of all the trials

for i = 1:trials
    p = 12 * (i-1);        
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    plot(sensor(:,1+p),'LineWidth',3)
    title('Whisker sensor movement profile 1');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')

      
    subplot(3,4,2)
    plot(sensor(:,2+p),'LineWidth',3)
    title('Whisker sensor movement profile 2');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')

    
    subplot(3,4,3)
    plot(sensor(:,3+p),'LineWidth',3)
    title('Whisker sensor movement profile 3');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
 
    
    subplot(3,4,4)
    plot(sensor(:,4+p),'LineWidth',3)
    title('Whisker sensor movement profile 4');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
    
    
    subplot(3,4,5)
    plot(sensor(:,5+p),'LineWidth',3)
    title('Whisker sensor movement profile 5');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
  
    
    subplot(3,4,6)
    plot(sensor(:,6+p),'LineWidth',3)
    title('Whisker sensor movement profile 6');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
    
    
    subplot(3,4,7)
    plot(sensor(:,7+p),'LineWidth',3)
    title('Whisker sensor movement profile 7');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
   
    
    subplot(3,4,8)
    plot(sensor(:,8+p),'LineWidth',3)
    title('Whisker sensor movement profile 8');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
   
    
    subplot(3,4,9)
    plot(sensor(:,9+p),'LineWidth',3)
    title('Whisker sensor movement profile 9');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
    
    
    subplot(3,4,10)
    plot(sensor(:,10+p),'LineWidth',3)
    title('Whisker sensor movement profile 10');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
   
    
    subplot(3,4,11)
    plot(sensor(:,11+p),'LineWidth',3)
    title('Whisker sensor movement profile 11');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
    
    
    subplot(3,4,12)
    plot(sensor(:,12+p),'LineWidth',3)
    title('Whisker sensor movement profile 12');
    xlabel('Data Points');
    ylabel('Pressure (Pa)')
    
    
    if DoSaveFile == 1        
        filename = sprintf('SensorsProfile_norm_%d.jpg', i) ;
        saveas(gcf,filename)
    end
end
end