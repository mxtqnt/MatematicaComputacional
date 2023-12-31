function l5ex19()
  clc;
  x = [2, 3, 4, 5, 6, 7];
  y = [0.5, 0.3333, 0.25, 0.2, 0.1667, 0.1429];
  xdef = 5.5;
  
  ordem = input("Defina o grau do polinonimo: ");
  
  coeficientes = elementos(ordem, x, y);
  [r2, coeficiteDeterminacao] = determinacao(coeficientes, x, y);
  
  fprintf("Os pontos: ") 
  for i = 1:numel(x)
    fprintf("(%d, %d) ", x(i), y(i))    
  endfor

  fprintf("Gerando a função: \nf(x) = ")
  fprintf("%d + ", coeficientes(1))
  for i = 2:numel(coeficientes)
    fprintf("%d.x^%d", coeficientes(i), (i-1))
    if i <= (numel(coeficientes)-1)
      fprintf(" + ")
    endif
  endfor
  
  fprintf("\nEstimando x para %d o polinomio resulta em: %d\nR2=%d, R=%d\n", xdef, funcao(coeficientes, xdef), r2, coeficiteDeterminacao);
  plotrosa(ordem, x, y, coeficientes, xdef);
endfunction

function x = elementos(ordem, x, y)
  matrizA = zeros(ordem+1, ordem+2);
  [~, n] = size(x);
  for i = 1:(ordem+1)
    for j = 1:i
      k = i+j-2;
      soma = 0;
      for l = 1:n
        soma = soma + ((x(l))^k);
      endfor
      matrizA(i, j) = soma;
      matrizA(j, i) = soma;
    endfor
    soma = 0;
    for l = 1:n
      soma = soma + (y(l))*((x(l))^(i-1));
    endfor
    matrizA(i, ordem+2) = soma;
  endfor
  A = matrizA(:, 1:(end-1));
  b = matrizA(:, end);
  x = A\b;
endfunction

function [r2, coeficiteDeterminacao] = determinacao(coeficientes, x, y)
  st = 0;
  sr = 0;
  for i = 1:numel(x)
    func = funcao(coeficientes, (x(i)));
    sr = sr + (y(i) - func)^2;
    st = st + (y(i) - mean(y))^2;
  endfor
  r2 = (st - sr)/st;
  coeficiteDeterminacao = sqrt(r2);
endfunction

function y = funcao(coeficientes, xdef)
  y = 0;
  for i = numel(coeficientes):-1:1 % Decrementa os coeficientes
    y = y + coeficientes(i) * xdef^(i - 1); % Soma acumulativa
  endfor
endfunction

function plotrosa(ordem, x, y, coeficientes, pontim)
  xauxiliar = (x(1)):0.1:(x(end));
  yauxiliar = (x(1)):0.1:(x(end));
  
  for i = 1:numel(xauxiliar)
    yauxiliar(i) = funcao(coeficientes, xauxiliar(i));
  endfor
  plot(xauxiliar, yauxiliar, 'linewidth', 5, 'color', [0.9922, 0.0000, 0.5490]);
  hold on;
  plot(x, y, 'marker', 'o', 'markersize', 10, 'markerfacecolor', [0.5019607843,0,0.7058823529], 'LineStyle', 'none');
  hold on;
  plot(pontim, (funcao(coeficientes, pontim)), 'marker', 'o', 'markersize', 15, 'markerfacecolor', 'b', 'LineStyle', 'none');
  title(sprintf('Polinomio de ordem %d', ordem))
  flegend = legend('Polinomio','Dados','x = 5.5', 'Location', 'northeast');
  set(flegend, 'FontSize', 15);
  xlabel("x");
  ylabel("y");
  grid on;
  hold off;
endfunction