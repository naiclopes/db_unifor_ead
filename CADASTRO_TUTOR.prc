CREATE OR REPLACE PROCEDURE CADASTRO_TUTOR(P_NOME_TUTOR      IN TUTOR.NOME_TUTOR%TYPE,
                                           P_DATA_NASCIMENTO IN TUTOR.DATA_NASCIMENTO%TYPE,
                                           P_CPF             IN TUTOR.CPF%TYPE,
                                           P_DATA_INCLUSAO   IN TUTOR.DATA_INCLUSAO%TYPE,
                                           P_DATA_EXCLUSAO   IN TUTOR.DATA_EXCLUSAO%TYPE) IS

BEGIN

  INSERT INTO TUTOR
    (COD_TUTOR,
     NOME_TUTOR,
     DATA_NASCIMENTO,
     CPF,
     DATA_INCLUSAO,
     DATA_EXCLUSAO,
     USUARIO_INSERCAO_REGISTRO,
     DATA_INSERCAO_REGISTO,
     VERSAO)
    SELECT TUTOR_SEQ.NEXTVAL,
           P_NOME_TUTOR,
           P_DATA_NASCIMENTO,
           P_CPF,
           P_DATA_INCLUSAO,
           P_DATA_EXCLUSAO,
           USER,
           SYSDATE,
           0
      FROM TUTOR
     WHERE CPF = P_CPF HAVING COUNT(*) = 0;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    raise_application_error(-200007, 'Erro TUTOR ' || sqlerrm);
END CADASTRO_TUTOR;
