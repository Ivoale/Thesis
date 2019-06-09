function plotted = plot_standardZscore_short(standardZscore,trials,DoSaveFile)
% Plot the moving standard deviation of the z-scores of all the trials

for i = 1:trials
    p = 12 * (i-1);
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    plot(standardZscore(:,1+p))
    title('Standard Zscore sensor 1');
    xlabel('Data Points');
    
    subplot(3,4,2)
    plot(standardZscore(:,2+p))
    title('Standard Zscore sensor 2');
    xlabel('Data Points');
    
    subplot(3,4,3)
    plot(standardZscore(:,3+p))
    title('Standard Zscore sensor 3');
    xlabel('Data Points');
    
    subplot(3,4,4)
    plot(standardZscore(:,4+p))
    title('Standard Zscore sensor 4');
    xlabel('Data Points');
    
    subplot(3,4,5)
    plot(standardZscore(:,5+p))
    title('Standard Zscore sensor 5');
    xlabel('Data Points');
    
    subplot(3,4,6)
    plot(standardZscore(:,6+p))
    title('Standard Zscore sensor 6');
    xlabel('Data Points');
    
    subplot(3,4,7)
    plot(standardZscore(:,7+p))
    title('Standard Zscore sensor 7');
    xlabel('Data Points');
    
    subplot(3,4,8)
    plot(standardZscore(:,8+p))
    title('Standard Zscore sensor 8');
    xlabel('Data Points');
    
    subplot(3,4,9)
    plot(standardZscore(:,9+p))
    title('Standard Zscore sensor 9');
    xlabel('Data Points');
    
    subplot(3,4,10)
    plot(standardZscore(:,10+p))
    title('Standard Zscore sensor 10');
    xlabel('Data Points');
    
    subplot(3,4,11)
    plot(standardZscore(:,11+p))
    title('Standard Zscore sensor 11');
    xlabel('Data Points');
    
    subplot(3,4,12)
    plot(standardZscore(:,12+p))
    title('Standard Zscore sensor 12');
    xlabel('Data Points');
    
    if DoSaveFile == 1
        filename = sprintf('Standard_zscore_%d.jpg', i) ;
        saveas(gcf,filename)
    end
end
end
