function plotted = plot_normStandardZscore(normli,DoSaveFile)
% Plot the normalised standard deviation of the 12 sensors on just one graph

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(normli(:,1))
title('Norm Standard Zscore sensor 1');
xlabel('Data Points');

subplot(3,4,2)
plot(normli(:,2))
title('Standard Zscore sensor 2');
xlabel('Data Points');

subplot(3,4,3)
plot(normli(:,3))
title('Standard Zscore sensor 3');
xlabel('Data Points');

subplot(3,4,4)
plot(normli(:,4))
title('Standard Zscore sensor 4');
xlabel('Data Points');

subplot(3,4,5)
plot(normli(:,5))
title('Standard Zscore sensor 5');
xlabel('Data Points');

subplot(3,4,6)
plot(normli(:,6))
title('Standard Zscore sensor 6');
xlabel('Data Points');

subplot(3,4,7)
plot(normli(:,7))
title('Standard Zscore sensor 7');
xlabel('Data Points');

subplot(3,4,8)
plot(normli(:,8))
title('Standard Zscore sensor 8');
xlabel('Data Points');

subplot(3,4,9)
plot(normli(:,9))
title('Standard Zscore sensor 9');
xlabel('Data Points');

subplot(3,4,10)
plot(normli(:,10))
title('Standard Zscore sensor 10');
xlabel('Data Points');

subplot(3,4,11)
plot(normli(:,11))
title('Standard Zscore sensor 11');
xlabel('Data Points');

subplot(3,4,12)
plot(normli(:,12))
title('Standard Zscore sensor 12');
xlabel('Data Points');

if DoSaveFile == 1        
        filename = sprintf('Standar_zscore_norm_%d.jpg', i) ;
        saveas(gcf,filename)
    end

end
