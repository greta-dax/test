
CREATE SEQUENCE public.competence_competence_id_seq;

CREATE TABLE public.competence (
                competence_id BIGINT NOT NULL DEFAULT nextval('public.competence_competence_id_seq'),
                nom VARCHAR NOT NULL,
                parent_competence_id BIGINT,
                CONSTRAINT competence_pk PRIMARY KEY (competence_id)
);


ALTER SEQUENCE public.competence_competence_id_seq OWNED BY public.competence.competence_id;

CREATE UNIQUE INDEX competence_idx
 ON public.competence USING BTREE
 ( nom );

CREATE SEQUENCE public.ville_ville_id_seq;

CREATE TABLE public.ville (
                ville_id BIGINT NOT NULL DEFAULT nextval('public.ville_ville_id_seq'),
                nom VARCHAR NOT NULL,
                longitude NUMERIC(7,5) NOT NULL,
                latitude NUMERIC(7,5) NOT NULL,
                CONSTRAINT ville_pk PRIMARY KEY (ville_id)
);


ALTER SEQUENCE public.ville_ville_id_seq OWNED BY public.ville.ville_id;

CREATE SEQUENCE public.formation_formation_id_seq;

CREATE TABLE public.formation (
                formation_id BIGINT NOT NULL DEFAULT nextval('public.formation_formation_id_seq'),
                libelle VARCHAR NOT NULL,
                duree INTEGER NOT NULL,
                plan_cours VARCHAR NOT NULL,
                prix NUMERIC(7,2) NOT NULL,
                ville_id BIGINT NOT NULL,
                CONSTRAINT formation_id_pk PRIMARY KEY (formation_id)
);


ALTER SEQUENCE public.formation_formation_id_seq OWNED BY public.formation.formation_id;

CREATE SEQUENCE public.participant_participant_id_seq;

CREATE TABLE public.participant (
                participant_id BIGINT NOT NULL DEFAULT nextval('public.participant_participant_id_seq'),
                formation_id BIGINT NOT NULL,
                nom VARCHAR NOT NULL,
                prenom VARCHAR NOT NULL,
                date_naissance DATE NOT NULL,
                CONSTRAINT participant_id_pk PRIMARY KEY (participant_id)
);


ALTER SEQUENCE public.participant_participant_id_seq OWNED BY public.participant.participant_id;

CREATE INDEX participant_idx
 ON public.participant USING BTREE
 ( formation_id );

CREATE SEQUENCE public.formateur_formateur_id_seq;

CREATE TABLE public.formateur (
                formateur_id BIGINT NOT NULL DEFAULT nextval('public.formateur_formateur_id_seq'),
                nom VARCHAR NOT NULL,
                prenom VARCHAR NOT NULL,
                prix_jour NUMERIC(6,2) NOT NULL,
                CONSTRAINT formateur_id_pk PRIMARY KEY (formateur_id)
);


ALTER SEQUENCE public.formateur_formateur_id_seq OWNED BY public.formateur.formateur_id;

CREATE INDEX formateur_idx
 ON public.formateur
 ( nom );

CREATE INDEX formateur_idx1
 ON public.formateur
 ( prenom );

CREATE TABLE public.formateur_competence (
                competence_id BIGINT NOT NULL,
                formateur_id BIGINT NOT NULL,
                CONSTRAINT formateur_competence_pk PRIMARY KEY (competence_id, formateur_id)
);


CREATE TABLE public.formation_formateur (
                formation_id BIGINT NOT NULL,
                formateur_id BIGINT NOT NULL,
                CONSTRAINT formation_formateur_pk PRIMARY KEY (formation_id, formateur_id)
);


ALTER TABLE public.formateur_competence ADD CONSTRAINT competence_formateur_competence_fk
FOREIGN KEY (competence_id)
REFERENCES public.competence (competence_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.competence ADD CONSTRAINT competence_competence_fk
FOREIGN KEY (parent_competence_id)
REFERENCES public.competence (competence_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.formation ADD CONSTRAINT ville_formation_fk
FOREIGN KEY (ville_id)
REFERENCES public.ville (ville_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.formation_formateur ADD CONSTRAINT formation_formation_formateur_fk
FOREIGN KEY (formation_id)
REFERENCES public.formation (formation_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.participant ADD CONSTRAINT formation_participant_fk
FOREIGN KEY (formation_id)
REFERENCES public.formation (formation_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.formation_formateur ADD CONSTRAINT formateur_formation_formateur_fk
FOREIGN KEY (formateur_id)
REFERENCES public.formateur (formateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.formateur_competence ADD CONSTRAINT formateur_formateur_competence_fk
FOREIGN KEY (formateur_id)
REFERENCES public.formateur (formateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
