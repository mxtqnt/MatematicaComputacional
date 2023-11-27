function interpolacao()
  clc;
  passo = 0.1;
  x = [2, 3, 4, 5, 6, 7];
  y = [0.5, 0.3333, 0.25, 0.2, 0.1667, 0.1429];
  xestimado = [5.5];
  
  ordem = input('Qual a ordem ');
  
  coeficientes = elementos(ordem, x, y)
  [r2, coeficientedeterminacao] = determinacao(x, y, coeficientes)
  plotagem(x, y, xestimado, passo, coeficientes);
endfunction

function plotagem(x, y, xestimado, passo, coeficientes)
  xauxiliar = x(1):passo:x(end);
  yauxiliar = x(1):passo:x(end);
  
  for i = 1:numel(xauxiliar)
    yauxiliar(i) = funcao(coeficientes, xauxiliar(i));
  endfor
  
  plot(x, y, 'marker', 'o', 'linestyle', 'none');
  hold on;
  plot(xauxiliar, yauxiliar);
  plot(xestimado, funcao(coeficientes, xestimado), 'marker', 'o');
  hold on;
endfunction

function coeficientes = elementos(ordem, x, y)
   matrizA = zeros(ordem + 1, ordem + 2);
   [~, n] = size(x);
   for i = 1:(ordem+1)
     for j = 1:i
       k = i + j - 2;
       soma = 0;
       for l = 1:n
         soma = soma + x(l)^k;
       endfor
       matrizA(i,j) = soma;
       matrizA(j,i) = soma;
     endfor
     soma = 0;
     for l = 1:n
       soma = soma + y(l) * x(l)^(i-1);
     endfor
     matrizA(i, (ordem + 2)) = soma;
   endfor
   % FAtiar separando a e b
   A = matrizA(:, 1:(end-1));
   b = matrizA(:, end);
   coeficientes = A\b;
endfunction

function [r2, coeficientedeterminacao] = determinacao(x, y, coeficientes)
  st = 0;
  sr = 0;
  for i = numel(coeficientes)
    st = st + (y(i) - mean(y))^2;
    sr = sr + (y(i) - (funcao(coeficientes, x(i))))^2;
  endfor
  r2 = (st-sr)/st;
  coeficientedeterminacao = sqrt(r2);
endfunction

function y = funcao(coeficientes, ponto)
  y = 0;
  for i = 1:numel(coeficientes)
    y = y + coeficientes(i) * ponto^(i - 1);
  endfor
endfunction