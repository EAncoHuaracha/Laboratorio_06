DIGITO [0-9]
NUMERO {DIGITO}+(\.{DIGITO}+)?
OPERACIONES [+\-*/%^]
%{
	char operaciones;
	/*variables*/
	float num1=0, num2=0, rpta=0;

	int f1=0,f2=-1;
	void calcular();
%}


%%
{NUMERO} {
	if(f1 == 0){
		/*Conversion a tipo float*/
		num1 = atof(yytext);
		f1 = 1;
	}else if(f2 == 0){

		/*Conversion a tipo float*/
		num2 = atof(yytext);
		f2 = 1;
	}
				 }
{OPERACIONES} {
	if(f1 == 1){
		operaciones = (char)*yytext;
		f2 = 0;
	}
							}
[\n] {
	if(f1 == 1 && f2 == 1){
		calcular();
		f1 = 0;
		f2 = -1;
	}
}
%%

int yywrap(){}

int main(){
	yylex();
	return 0;
}

void calcular(){
	/*Se calcula la operacion indicada por el usuario*/
	switch(operaciones){

		case '+':
			rpta = num1 + num2;
			break;

		case '-':
			rpta = num1 - num2;
			break;

		case '*':
			rpta = num1 * num2;
			break;

		case '/':
			if(num2 == 0){
				printf("Error No se acepta division entre 0\n");
				rpta = -1;
				break;

			}
			else{
				rpta = num1 / num2;
			}
			break;
		
		case '%':
			rpta = (int)num1 % (int)num2;
			break;
		
		case '^':
			/*iniciar*/
			rpta = 1;
			for(int i = 0; i < num2; i++){
				rpta *= num1; 
			}
			break;
		
		default:
			printf("No se reconoce la operacion");
			break; 
	}
	printf("Respuesta: %f \n",rpta);
}

