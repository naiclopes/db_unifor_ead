CREATE OR REPLACE PROCEDURE CADASTRO_ALUNO(P_NOME_ALUNO      IN ALUNO.NOME_ALUNO%TYPE,
                                           P_DATA_NASCIMENTO IN ALUNO.DATA_NASCIMENTO%TYPE,
                                           P_CPF             IN ALUNO.CPF%TYPE,
                                           P_NOME_MAE        IN ALUNO.NOME_MAE%TYPE,
                                           P_DATA_INCLUSAO   IN ALUNO.DATA_INCLUSAO%TYPE,
                                           P_DATA_EXCLUSAO   IN ALUNO.DATA_EXCLUSAO%TYPE) IS

BEGIN

  INSERT INTO ALUNO
    (COD_ALUNO,
     NOME_ALUNO,
     DATA_NASCIMENTO,
     CPF,
     NOME_MAE,
     DATA_INCLUSAO,
     DATA_EXCLUSAO,
     USUARIO_INSERCAO_REGISTRO,
     DATA_INSERCAO_REGISTO,
     VERSAO)
    SELECT ALUNO_SEQ.NEXTVAL,
           P_NOME_ALUNO,
           P_DATA_NASCIMENTO,
           P_CPF,
           P_NOME_MAE,
           P_DATA_INCLUSAO,
           P_DATA_EXCLUSAO,
           USER,
           SYDATE,
           0
      FROM ALUNO
     WHERE CPF = P_CPF HAVING COUNT(*) = 0;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    raise_application_error(-200007, 'Erro ALUNO ' || sqlerrm);
END CADASTRO_ALUNO;
