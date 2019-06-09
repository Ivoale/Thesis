function plotted = plot_meanZscore9_short(meanZscore,trials,DoSaveFile)
% Plot the moving average of the z-scores of all the trials

for i = 1:trials
    p = 12 * (i-1);
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    plot(meanZscore(:,1+p))
    title('Mean Zscore sensor 1');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,2)
    plot(meanZscore(:,2+p))
    title('Mean Zscore sensor 2');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,3)
    plot(meanZscore(:,3+p))
    title('Mean Zscore sensor 3');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,4)
    plot(meanZscore(:,4+p))
    title('Mean Zscore sensor 4');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,5)
    plot(meanZscore(:,5+p))
    title('Mean Zscore sensor 5');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,6)
    plot(meanZscore(:,6+p))
    title('Mean Zscore sensor 6');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,7)
    plot(meanZscore(:,7+p))
    title('Mean Zscore sensor 7');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,8)
    plot(meanZscore(:,8+p))
    title('Mean Zscore sensor 8');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,9)
    plot(meanZscore(:,9+p))
    title('Mean Zscore sensor 9');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,10)
    plot(meanZscore(:,10+p))
    title('Mean Zscore sensor 10');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,11)
    plot(meanZscore(:,11+p))
    title('Mean Zscore sensor 11');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    subplot(3,4,12)
    plot(meanZscore(:,12+p))
    title('Mean Zscore sensor 12');
    xlabel('Data Points');
    ylabel('Pressure (hPa)');
    
    if DoSaveFile == 1
        filename = sprintf('Mean_Zscores_%d.jpg', i) ;
        saveas(gcf,filename)
    end
end
end
