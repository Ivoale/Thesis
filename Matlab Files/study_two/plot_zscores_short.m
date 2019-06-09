function plotted = plot_zscores_short(Zscore,trials,DoSaveFile)
% Plot the z-scores of all the trials

for i = 1:trials
    p = 12 * (i-1);
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    plot(Zscore(:,1+p))
    title('Whisker sensor z-score 1');
    xlabel('Data Points');
    
    subplot(3,4,2)
    plot(Zscore(:,2+p))
    title('Whisker sensor z-score 2');
    xlabel('Data Points');
    
    subplot(3,4,3)
    plot(Zscore(:,3+p))
    title('Whisker sensor z-score 3');
    xlabel('Data Points');
    
    subplot(3,4,4)
    plot(Zscore(:,4+p))
    title('Whisker sensor z-score 4');
    xlabel('Data Points');
    
    subplot(3,4,5)
    plot(Zscore(:,5+p))
    title('Whisker sensor z-score 5');
    xlabel('Data Points');
    
    subplot(3,4,6)
    plot(Zscore(:,6+p))
    title('Whisker sensor z-score 6');
    xlabel('Data Points');
    
    subplot(3,4,7)
    plot(Zscore(:,7+p))
    title('Whisker sensor z-score 7');
    xlabel('Data Points');
    
    subplot(3,4,8)
    plot(Zscore(:,8+p))
    title('Whisker sensor z-score 8');
    xlabel('Data Points');
    
    subplot(3,4,9)
    plot(Zscore(:,9+p))
    title('Whisker sensor z-score 9');
    xlabel('Data Points');
    
    subplot(3,4,10)
    plot(Zscore(:,10+p))
    title('Whisker sensor z-score 10');
    xlabel('Data Points');
    
    subplot(3,4,11)
    plot(Zscore(:,11+p))
    title('Whisker sensor z-score 11');
    xlabel('Data Points');
    
    subplot(3,4,12)
    plot(Zscore(:,12+p))
    title('Whisker sensor z-score 12');
    xlabel('Data Points');
    
    if DoSaveFile == 1
        filename = sprintf('Zscores_%d.jpg', i) ;
        saveas(gcf,filename)
    end
end
end
