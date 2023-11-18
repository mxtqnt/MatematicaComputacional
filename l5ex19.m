function l5ex19()
  clc;
  x = [2, 3, 4, 5, 6, 7];
  y = [0.5, 0.3333, 0.25, 0.2, 0.1667, 0.1429];
  
  %x = [0, 1, 2, 3, 4, 5];
  %y = [2.1, 7.7, 13.6, 27.2, 40.9, 61.1];
  
  ordem = input("Defina o grau do polinonimo: ");
  fprintf("Ordem escolhida: %i \n", ordem)
  
  coeficientes = elementos(ordem, x, y)
  [r2, coeficiteDeterminacao] = determinacao(coeficientes, x, y)
  
  plotrosa(x, y)
endfunction

function x = elementos(ordem, x, y)
  matrizA = zeros(ordem+1, ordem+2);
  [~, n] = size(x)
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

function y = funcao(coeficientes, x)
  y = 0;
  for i = numel(coeficientes):-1:1 % Decrementa os coeficientes
    y = y + coeficientes(i) * x^(i - 1); % Somatorio???
  endfor
endfunction

function plotrosa(x,y)
  for i = 1:numel(x)
    plot(x(i), y(i), 'marker', 'o', 'markersize', 10, 'markerfacecolor', [0.9922, 0.0000, 0.5490], 'DisplayName', 'Pontos')
    hold on;
  endfor
  hold off;
  % Curva fit: 
  %polyfit
endfunction
