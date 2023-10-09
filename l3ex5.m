function l3ex5()
  clc;
  [matrizcoeficientes, matrizindependentes] = sistema();
  matrizampliada = [matrizcoeficientes, matrizindependentes];
  matrizampliada = pivotamento(matrizampliada);
  matrizampliada = eliminacao(matrizcoeficientes, matrizindependentes, matrizampliada);
  vetorraiz = zeros(size(matrizampliada(:,1)));
  vetorraiz = substituir(matrizampliada, vetorraiz);
  fprintf("Sistema: \n 2x + z = 2 \n 5x - y + z = 5 \n -x + 2y + 2z = 0")
  fprintf("\n\nVetor raiz: x1=%d x2=%d x3=%d", vetorraiz(1), vetorraiz(2), vetorraiz(end))
endfunction

function [matrizcoeficientes, matrizindependentes] = sistema()
  matrizcoeficientes = [ 2, 0,1;
                         5,-1,1;
                        -1, 2,2];
                     
  matrizindependentes = [2;
                         5;
                         0];
             
endfunction

function matrizampliada = pivotamento(matrizampliada)
  [linha,coluna] = size(matrizampliada);
  for i = 1:linha-1
    [valormaximo, linhamaxima] = max(abs(matrizampliada(i:linha, i)));
    linhamaxima = i + linhamaxima -1;
    aux =  matrizampliada(i,:);
    matrizampliada(i,:) = matrizampliada(linhamaxima,:); 
    matrizampliada(linhamaxima,:) = aux;
  endfor
endfunction

function matrizampliada = eliminacao(matrizcoeficientes, matrizindependentes, matrizampliada)
  [n,m] = size(matrizcoeficientes);
  for k = 1:n-1
        [valormaximo, linhamaxima] = max(abs(matrizampliada(k:n, k)));
        linhamaxima = linhamaxima + k - 1;
        matrizampliada([k, linhamaxima], :) = matrizampliada([linhamaxima, k], :);

        for i = k+1:n
            fator = matrizampliada(i, k) / matrizampliada(k, k);
            matrizampliada(i, k:end) = matrizampliada(i, k:end) - fator * matrizampliada(k, k:end);
        end
    end
endfunction


function vetorraiz =  substituir(matrizampliada, vetorraiz)
  maximopivo = size(matrizampliada,1);
  for i = maximopivo:-1:1
    pivo = matrizampliada(i,i);
    if i == maximopivo
      vetorraiz(i) = matrizampliada(i,end)/pivo;
      matrizampliada(i-1:-1:1,i)=vetorraiz(i)*matrizampliada(i-1:-1:1,i);
    else
      sub = sum(matrizampliada(i,i+1:end-1));
      vetorraiz(i)=((matrizampliada(i,end)-sub)/matrizampliada(i,i));
      if i> 1
        matrizampliada(i-1:-1:1,i)=vetorraiz(i)*matrizampliada(i-1:-1:1,i);
      endif
   endif
  endfor
endfunction