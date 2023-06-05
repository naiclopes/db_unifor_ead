CREATE OR RELACE PROCEDURE CADASTRO_TUTOR(
P_COD_TUTOR IN TUTOR.COD_TUTOR%TYPE,
P_NOME_TUTOR IN TUTOR.NOME_TUTOR%TYPE,
P_DATA_NASCIMENTO IN TUTOR.DATA_NASCIMENTO%TYPE,
P_CPF IN TUTOR.CPF%TYPE,
P_DATA_INCLUSAO IN TUTOR.DATA_INCLUSAO%TYPE,
P_DATA_EXCLUSAO IN TUTOR.DATA_EXCLUSAO%TYPE)
 IS
 
BEGIN


INSERT INTO TUTOR (
COD_TUTOR ,
NOME_TUTOR ,
DATA_NASCIMENTO ,
CPF ,
DATA_INCLUSAO ,
DATA_EXCLUSAO ,
USUARIO_INSERCAO_REGISTRO ,
DATA_INSERCAO_REGISTO ,
VERSAO)
SELECT TUTOR_SEQ ,
P_NOME_TUTOR ,
P_DATA_NASCIMENTO ,
P_CPF ,
P_DATA_INCLUSAO ,
P_DATA_EXCLUSAO ,
GET_USUARIO_SISTEMA ,
SYSDATE ,
0 FROM TUTOR
WHERE CPF = P_CPF
HAVING COUNT(*) = 0;
COMMIT;


EXCEPTION 
WHEN OTHERS THEN
ROOLBACK;
raise_application_error(-200007, 'Erro TUTOR '||sqlerrm);
END;

END CADASTRO_TUTOR;