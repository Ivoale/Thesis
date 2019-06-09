function plotted = plot_normStandardZscore_short(normli,trials,DoSaveFile)
% Plot the normalised moving standard deviation of the z-scores of all the trials

for i = 1:trials
    p = 12 * (i-1);
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    plot(normli(:,1+p))
    title('Norm Standard Zscore sensor 1');
    xlabel('Data Points');
    
    subplot(3,4,2)
    plot(normli(:,2+p))
    title('Standard Zscore sensor 2');
    xlabel('Data Points');
    
    subplot(3,4,3)
    plot(normli(:,3+p))
    title('Standard Zscore sensor 3');
    xlabel('Data Points');
    
    subplot(3,4,4)
    plot(normli(:,4+p))
    title('Standard Zscore sensor 4');
    xlabel('Data Points');
    
    subplot(3,4,5)
    plot(normli(:,5+p))
    title('Standard Zscore sensor 5');
    xlabel('Data Points');
    
    subplot(3,4,6)
    plot(normli(:,6+p))
    title('Standard Zscore sensor 6');
    xlabel('Data Points');
    
    subplot(3,4,7)
    plot(normli(:,7+p))
    title('Standard Zscore sensor 7');
    xlabel('Data Points');
    
    subplot(3,4,8)
    plot(normli(:,8+p))
    title('Standard Zscore sensor 8');
    xlabel('Data Points');
    
    subplot(3,4,9)
    plot(normli(:,9+p))
    title('Standard Zscore sensor 9');
    xlabel('Data Points');
    
    subplot(3,4,10)
    plot(normli(:,10+p))
    title('Standard Zscore sensor 10');
    xlabel('Data Points');
    
    subplot(3,4,11)
    plot(normli(:,11+p))
    title('Standard Zscore sensor 11');
    xlabel('Data Points');
    
    subplot(3,4,12)
    plot(normli(:,12+p))
    title('Standard Zscore sensor 12');
    xlabel('Data Points');
    
    if DoSaveFile == 1
        filename = sprintf('Standar_zscore_norm_%d.jpg', i) ;
        saveas(gcf,filename)
    end
end
end
