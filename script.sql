-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui

CREATE DATABASE prova_pbd

CREATE Table tb_student_prediction(
    student_id SERIAL PRIMARY key,
    salary int,
    father_edu int,
    mother_edu int,
    partner int,
    prep_exam int,
    grade int
);



-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui

DO $$
    DECLARE
        cur_aprovados_pais_phd REFCURSOR;
        v_students int;
    BEGIN
        OPEN cur_aprovados_pais_phd FOR
        SELECT count(studentid) from tb_student_prediction
        WHERE father_edu = 6
        OR mother_edu = 6;

    LOOP
        FETCH cur_aprovados_pais_phd into v_students;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'QUANTIDADE DE ALUNOS APROVADOS COM PAIS PHD: %', v_students;
    END LOOP;  

    CLOSE cur_aprovados_pais_phd;
END $$

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------