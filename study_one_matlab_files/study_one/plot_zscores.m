function plotted = plot_zscores(Zscore,DoSaveFile)
% Plot the z-scores of the 12 sensors on just one graph

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(Zscore(:,1))
title('Whisker sensor z-score 1');
xlabel('Data Points');

subplot(3,4,2)
plot(Zscore(:,2))
title('Whisker sensor z-score 2');
xlabel('Data Points');

subplot(3,4,3)
plot(Zscore(:,3))
title('Whisker sensor z-score 3');
xlabel('Data Points');

subplot(3,4,4)
plot(Zscore(:,4))
title('Whisker sensor z-score 4');
xlabel('Data Points');

subplot(3,4,5)
plot(Zscore(:,5))
title('Whisker sensor z-score 5');
xlabel('Data Points');

subplot(3,4,6)
plot(Zscore(:,6))
title('Whisker sensor z-score 6');
xlabel('Data Points');

subplot(3,4,7)
plot(Zscore(:,7))
title('Whisker sensor z-score 7');
xlabel('Data Points');

subplot(3,4,8)
plot(Zscore(:,8))
title('Whisker sensor z-score 8');
xlabel('Data Points');

subplot(3,4,9)
plot(Zscore(:,9))
title('Whisker sensor z-score 9');
xlabel('Data Points');

subplot(3,4,10)
plot(Zscore(:,10))
title('Whisker sensor z-score 10');
xlabel('Data Points');

subplot(3,4,11)
plot(Zscore(:,11))
title('Whisker sensor z-score 11');
xlabel('Data Points');

subplot(3,4,12)
plot(Zscore(:,12))
title('Whisker sensor z-score 12');
xlabel('Data Points');

if DoSaveFile == 1
    saveas(gcf,'Zscores.jpg')
end

end
