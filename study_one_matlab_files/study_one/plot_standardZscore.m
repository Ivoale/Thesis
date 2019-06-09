function plotted = plot_standardZscore(standardZscore,DoSaveFile)
% Plot the moving standard deviation of the z-scores of the 12 sensors on just one graph

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(standardZscore(:,1))
title('Standard Zscore sensor 1');
xlabel('Data Points');

subplot(3,4,2)
plot(standardZscore(:,2))
title('Standard Zscore sensor 2');
xlabel('Data Points');

subplot(3,4,3)
plot(standardZscore(:,3))
title('Standard Zscore sensor 3');
xlabel('Data Points');

subplot(3,4,4)
plot(standardZscore(:,4))
title('Standard Zscore sensor 4');
xlabel('Data Points');

subplot(3,4,5)
plot(standardZscore(:,5))
title('Standard Zscore sensor 5');
xlabel('Data Points');

subplot(3,4,6)
plot(standardZscore(:,6))
title('Standard Zscore sensor 6');
xlabel('Data Points');

subplot(3,4,7)
plot(standardZscore(:,7))
title('Standard Zscore sensor 7');
xlabel('Data Points');

subplot(3,4,8)
plot(standardZscore(:,8))
title('Standard Zscore sensor 8');
xlabel('Data Points');

subplot(3,4,9)
plot(standardZscore(:,9))
title('Standard Zscore sensor 9');
xlabel('Data Points');

subplot(3,4,10)
plot(standardZscore(:,10))
title('Standard Zscore sensor 10');
xlabel('Data Points');

subplot(3,4,11)
plot(standardZscore(:,11))
title('Standard Zscore sensor 11');
xlabel('Data Points');

subplot(3,4,12)
plot(standardZscore(:,12))
title('Standard Zscore sensor 12');
xlabel('Data Points');

if DoSaveFile == 1
    saveas(gcf,'StandardZscores.jpg')
end

end
