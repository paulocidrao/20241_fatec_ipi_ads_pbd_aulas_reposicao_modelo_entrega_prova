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
END $$;

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui

DO $$
    DECLARE
        cur_alunos_sozinhos REFCURSOR;

        v_student int;
        v_nome_tabela VARCHAR(200) := 'tb_student_prediction';
        v_partner int := 2;
    BEGIN
        OPEN cur_alunos_sozinhos FOR EXECUTE
        FORMAT(
            '
                SELECT count(studentid)
                from %s
                WHERE partner = $1
                AND grade > 0

            ',
            v_nome_tabela
        )USING v_partner;
        
    LOOP
        FETCH cur_alunos_sozinhos into v_student;
        EXIT WHEN NOT FOUND;
        IF v_student = 0 THEN
            RAISE NOTICE '-1';
        END IF;
        RAISE NOTICE '%', v_student;
    END LOOP;

    CLOSE cur_alunos_sozinhos;
END $$;

-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui

DO $$
    DECLARE
        cur_salario_frequencia CURSOR FOR
        SELECT count(studentid) from tb_student_prediction
        where salary = 5
        AND prep_exam = 2;

        v_students int;
    BEGIN
        OPEN cur_salario_frequencia;

    LOOP
        FETCH cur_salario_frequencia into v_students;

        EXIT WHEN NOT FOUND;

        RAISE NOTICE '%', v_students;
    END LOOP;

    CLOSE cur_salario_frequencia;
END $$

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------