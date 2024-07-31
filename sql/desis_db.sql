PGDMP  *                    |            desis_db    16.3    16.3      �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    desis_db    DATABASE     {   CREATE DATABASE desis_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';
    DROP DATABASE desis_db;
                postgres    false            �            1259    16405 	   candidate    TABLE     e   CREATE TABLE public.candidate (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.candidate;
       public         heap    postgres    false            �            1259    16415    commune    TABLE     z   CREATE TABLE public.commune (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    region_id integer
);
    DROP TABLE public.commune;
       public         heap    postgres    false            �            1259    16410    region    TABLE     Y   CREATE TABLE public.region (
    id integer NOT NULL,
    name character varying(100)
);
    DROP TABLE public.region;
       public         heap    postgres    false            �            1259    16400    social    TABLE     �   CREATE TABLE public.social (
    web boolean NOT NULL,
    tv boolean NOT NULL,
    rrss boolean NOT NULL,
    friend boolean NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.social;
       public         heap    postgres    false            �            1259    16449    social_id_seq    SEQUENCE     �   CREATE SEQUENCE public.social_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.social_id_seq;
       public          postgres    false    215            �           0    0    social_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.social_id_seq OWNED BY public.social.id;
          public          postgres    false    220            �            1259    16425    vote    TABLE     B  CREATE TABLE public.vote (
    name character varying(255) NOT NULL,
    alias character varying(255) NOT NULL,
    rut character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    candidate_id integer NOT NULL,
    commune_id integer NOT NULL,
    social_id integer NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.vote;
       public         heap    postgres    false            �            1259    16461    vote_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.vote_id_seq;
       public          postgres    false    219            �           0    0    vote_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.vote_id_seq OWNED BY public.vote.id;
          public          postgres    false    221            +           2604    16450 	   social id    DEFAULT     f   ALTER TABLE ONLY public.social ALTER COLUMN id SET DEFAULT nextval('public.social_id_seq'::regclass);
 8   ALTER TABLE public.social ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    215            ,           2604    16462    vote id    DEFAULT     b   ALTER TABLE ONLY public.vote ALTER COLUMN id SET DEFAULT nextval('public.vote_id_seq'::regclass);
 6   ALTER TABLE public.vote ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    219            �          0    16405 	   candidate 
   TABLE DATA           -   COPY public.candidate (id, name) FROM stdin;
    public          postgres    false    216   �!       �          0    16415    commune 
   TABLE DATA           6   COPY public.commune (id, name, region_id) FROM stdin;
    public          postgres    false    218   "       �          0    16410    region 
   TABLE DATA           *   COPY public.region (id, name) FROM stdin;
    public          postgres    false    217   r$       �          0    16400    social 
   TABLE DATA           ;   COPY public.social (web, tv, rrss, friend, id) FROM stdin;
    public          postgres    false    215   w%       �          0    16425    vote 
   TABLE DATA           `   COPY public.vote (name, alias, rut, email, candidate_id, commune_id, social_id, id) FROM stdin;
    public          postgres    false    219   �%       �           0    0    social_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.social_id_seq', 22, true);
          public          postgres    false    220            �           0    0    vote_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.vote_id_seq', 19, true);
          public          postgres    false    221            0           2606    16409    candidate candidate_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_pkey;
       public            postgres    false    216            4           2606    16419    commune commune_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.commune
    ADD CONSTRAINT commune_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.commune DROP CONSTRAINT commune_pkey;
       public            postgres    false    218            2           2606    16414    region region_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
       public            postgres    false    217            6           2606    16433    vote rut_unique 
   CONSTRAINT     I   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT rut_unique UNIQUE (rut);
 9   ALTER TABLE ONLY public.vote DROP CONSTRAINT rut_unique;
       public            postgres    false    219            .           2606    16455    social social_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.social
    ADD CONSTRAINT social_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.social DROP CONSTRAINT social_pkey;
       public            postgres    false    215            8           2606    16470    vote vote_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.vote DROP CONSTRAINT vote_pkey;
       public            postgres    false    219            :           2606    16434    vote candidate_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT candidate_fk FOREIGN KEY (candidate_id) REFERENCES public.candidate(id) NOT VALID;
 ;   ALTER TABLE ONLY public.vote DROP CONSTRAINT candidate_fk;
       public          postgres    false    216    4656    219            ;           2606    16444    vote commune_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT commune_fk FOREIGN KEY (commune_id) REFERENCES public.commune(id) NOT VALID;
 9   ALTER TABLE ONLY public.vote DROP CONSTRAINT commune_fk;
       public          postgres    false    219    218    4660            9           2606    16420    commune region_fk    FK CONSTRAINT     s   ALTER TABLE ONLY public.commune
    ADD CONSTRAINT region_fk FOREIGN KEY (region_id) REFERENCES public.region(id);
 ;   ALTER TABLE ONLY public.commune DROP CONSTRAINT region_fk;
       public          postgres    false    4658    217    218            <           2606    16456    vote social_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT social_fk FOREIGN KEY (social_id) REFERENCES public.social(id) NOT VALID;
 8   ALTER TABLE ONLY public.vote DROP CONSTRAINT social_fk;
       public          postgres    false    215    219    4654            �   Z   x�3���/>�R��(�$�ː�-�(/1/%_�=?����*.#��Ԥ����������9݊�3�����RS��b���� �!�      �   N  x�M�=n1���)���Z�����X�ҌW�Ā"�ܥ ��r��)\����򆂁4�|����͓�u�=�V%�8Z�}�+�~N�9*UMk7��*���m@��]���;?IIKk?�/|��WjI[��:��m��INV��0�LH/h�a�C��Z��&�@I����*�y�͑�`M7\ܛ�cj�n�󞞂PK�h?'��۳�����z̯c�V�=Z4-��[\ԪR&����h�g_�ۼ��R��C��*+L1�����v1����޲$ڲ���Kr��$�tǾ�Cb�T١�?��_�V��&z���L����֙S����[���M�!! #a�� j�Lx:B(����ӓ^�����;������w�)��dXe5��[QDkU/.���n�X����8\+�����݁=`��0Sɱ�x�0S�z����x)���3�ԕ�;���	�����9+�fAw�k(�C�\�h�;·[xt"]����1D9�P0k� ,���ϱx������QFz�S �,�)�+� ӽ��_�K~�b-��$�joey���1ĳ�6f�"�)����a�\���R�hz      �   �   x��=N�0��S���P���hAT4/Yc,9v��b�GHI������ӛy��TTG�C����C/�#�2�j��;�8+�3z�55�s�CxC�p�L�c
|E;ml��j�scp6�C��z��&�5=�{k���oh��i�.�|Oݩ��ֆ�Wj�ꈩ�/Gp��6$�3q�:�V"E��>����ԝ�:©�I�CW���^�a�荀���I����|.ş�4�i~�`���eh      �      x������ � �      �      x������ � �     