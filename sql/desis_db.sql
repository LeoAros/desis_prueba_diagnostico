PGDMP                      |            desis_db    16.3    16.3 $    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    name character varying(100) NOT NULL,
    region_id integer,
    id integer NOT NULL
);
    DROP TABLE public.commune;
       public         heap    postgres    false            �            1259    16471    commune_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commune_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.commune_id_seq;
       public          postgres    false    218            �           0    0    commune_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.commune_id_seq OWNED BY public.commune.id;
          public          postgres    false    222            �            1259    16410    region    TABLE     Y   CREATE TABLE public.region (
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
          public          postgres    false    221            -           2604    16472 
   commune id    DEFAULT     h   ALTER TABLE ONLY public.commune ALTER COLUMN id SET DEFAULT nextval('public.commune_id_seq'::regclass);
 9   ALTER TABLE public.commune ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    218            ,           2604    16450 	   social id    DEFAULT     f   ALTER TABLE ONLY public.social ALTER COLUMN id SET DEFAULT nextval('public.social_id_seq'::regclass);
 8   ALTER TABLE public.social ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    215            .           2604    16462    vote id    DEFAULT     b   ALTER TABLE ONLY public.vote ALTER COLUMN id SET DEFAULT nextval('public.vote_id_seq'::regclass);
 6   ALTER TABLE public.vote ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    219            �          0    16405 	   candidate 
   TABLE DATA           -   COPY public.candidate (id, name) FROM stdin;
    public          postgres    false    216   �%       �          0    16415    commune 
   TABLE DATA           6   COPY public.commune (name, region_id, id) FROM stdin;
    public          postgres    false    218   -&       �          0    16410    region 
   TABLE DATA           *   COPY public.region (id, name) FROM stdin;
    public          postgres    false    217   1       �          0    16400    social 
   TABLE DATA           ;   COPY public.social (web, tv, rrss, friend, id) FROM stdin;
    public          postgres    false    215   2       �          0    16425    vote 
   TABLE DATA           `   COPY public.vote (name, alias, rut, email, candidate_id, commune_id, social_id, id) FROM stdin;
    public          postgres    false    219   22       �           0    0    commune_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.commune_id_seq', 346, true);
          public          postgres    false    222            �           0    0    social_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.social_id_seq', 27, true);
          public          postgres    false    220            �           0    0    vote_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.vote_id_seq', 24, true);
          public          postgres    false    221            2           2606    16409    candidate candidate_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_pkey;
       public            postgres    false    216            6           2606    16477    commune commune_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.commune
    ADD CONSTRAINT commune_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.commune DROP CONSTRAINT commune_pkey;
       public            postgres    false    218            4           2606    16414    region region_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
       public            postgres    false    217            8           2606    16433    vote rut_unique 
   CONSTRAINT     I   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT rut_unique UNIQUE (rut);
 9   ALTER TABLE ONLY public.vote DROP CONSTRAINT rut_unique;
       public            postgres    false    219            0           2606    16455    social social_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.social
    ADD CONSTRAINT social_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.social DROP CONSTRAINT social_pkey;
       public            postgres    false    215            :           2606    16470    vote vote_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.vote DROP CONSTRAINT vote_pkey;
       public            postgres    false    219            <           2606    16434    vote candidate_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT candidate_fk FOREIGN KEY (candidate_id) REFERENCES public.candidate(id) NOT VALID;
 ;   ALTER TABLE ONLY public.vote DROP CONSTRAINT candidate_fk;
       public          postgres    false    4658    216    219            =           2606    16478    vote commune_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT commune_fk FOREIGN KEY (commune_id) REFERENCES public.commune(id) NOT VALID;
 9   ALTER TABLE ONLY public.vote DROP CONSTRAINT commune_fk;
       public          postgres    false    4662    219    218            ;           2606    16420    commune region_fk    FK CONSTRAINT     s   ALTER TABLE ONLY public.commune
    ADD CONSTRAINT region_fk FOREIGN KEY (region_id) REFERENCES public.region(id);
 ;   ALTER TABLE ONLY public.commune DROP CONSTRAINT region_fk;
       public          postgres    false    218    4660    217            >           2606    16456    vote social_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.vote
    ADD CONSTRAINT social_fk FOREIGN KEY (social_id) REFERENCES public.social(id) NOT VALID;
 8   ALTER TABLE ONLY public.vote DROP CONSTRAINT social_fk;
       public          postgres    false    219    215    4656            �   Z   x�3���/>�R��(�$�ː�-�(/1/%_�=?����*.#��Ԥ����������9݊�3�����RS��b���� �!�      �   �
  x�UXˎ�]�_�?�@�Z˙����=V�7Ȇj�:�Lu`��'�f������圪��l�"�,��T�*��.V�����M�w'��l�!9�
���.ِ���ȹҼ�2�/�[��\�!f����[!��6~��U�b?pɚ��Ÿ171�����Ƽm�x�4[j���\�C�d�4�E�X����Cŀ����l�*���(̓�W8,���}�0�����g[�O1ۻ�j����1��G�!pc��4�����zJ�%�>z{��\����
{X� 7��l';@X��G��h��y��AO�=�Hie>��Q�vܻ���Թ�µ�M�'�ˮ�uj��yk�.Q�jQPA<I��D4�޶6#̹��?�T�0[�G��li>�v�� T��pt���={dbm��S��8 `[��}+����w���*�Φ��3+󎎐m�<������~��`�ԩ,i�#�7�8�E�(��'�r 0T�};����o�Lv�R?=�{���g��#�?M?(ؘ��z$nX-qk�Y�צheޜ%��Ԏ<���ڰ&\����@H�/ͽ���۽�J\��ip;Kժ����4a��^4���8�xc�n�I�V/�?�ǈV��j�!����|I�¼��G<��K�L#�_W�.�Pfjыq�{X��m�R�	DTZ�@oܘ�!ñ��z�^>XY�^q+8���� �\v�u�1�4�n�:��/�!�p���q��5��u�Xa-:�L���F.��D�y�����6K�v��
�	{!�\�_6������͢�Fq�fP��8���;*�͋8��Thm^%���50�	��%+�Iy,����f	�G���;R�7�>P=��c�;�)���Y�M��)���CE�Mm�����/����S1:B�1�B��� �.�p�䘔(Y�~��h@i_�uW����'��{AP�&���K\͏�z��A�8}?2o»=#?�ƫ%lC2�`�˃���m������CG�l{����NG`9;��:	 jl0��pp��3AP���CԘ��4�dÇ��0F��"�R+39ՂҴa���t������
�nٽ�d�D)`��9IL��~>`���x>���yM��c ��ˁ������0}�[t�@n �Ï�+�}�hOA�����4����\��k2�#t<o�d�m�*\e�_:� ��JR,��i>	���^mSjV�.���E�!�}��w �Sv�X9��^���5�����$D��,|�}�*m��f�jGsU,.���	��!X�|s�-���w����I�D0s�ڎH�"��9	<�ks���r����iz�~7z�3� 	�!1���+�*�H�"ə���yEa�{}/��t� ���j��;�*`z��Q�tG�J>�Md�64/T�j��"ژ��@����-9��$�\�%*(���B.��o:u_�����Z���FM�����Уܗ���Fo�U�'-� `ܬ<�7F���s��}��Q!?��r����O�/����#���f�z9Tx=��H��<��2��=k����uމ?R�2w��Yc����[�2�[���%��4ET�漞�KIs<��Tr�p�nwF���>��T�ABА�Q�ҎI�D;��yN����LZ�Ψ4�l ��~��2(�w�*bM�O�$+KlMVܠ�g%qQ�1�'��A�FD*�Ot,��	�C�B$̶��d?���-�M�vD��'ҁb&ƸGPd������p�c�d�2)
l4�%m�(� ���D��rZ��2��#~T�6ma0��
�2)
,i'���K�_~��;�<��-hr�9�eLg�A-�$�?OⵓE����-jP�ǁ\P���1:��)H� �p��R��C
*�nz���5�d+2���?��81+��0��A��7�5OA ��E;{�L�������$�Y�gv	n����F�d��"d*Gׁp����L��k�]U��E�aWImX��Y$��-���ī�-KG��lg��Z�n��v�+(�7=�2�����Џ����F�(U5aΧ���a/�����A�����y��撸;�}ε�(��)�~F[�o�e%�+iU&��WwV	l#/��6��4k�J��:���=޼�d�p�-��f�4�R�J�#��<AIΪ�M� V�_��(XAP��|ti?K*s��$G��IJ"��#p���x{��z�V|�@>���h%����K�hv�7��$�M��-��U�hUC&��=����"���Y}J��{���U&d$���7oؐ�@�?�a]��z����	�剭�V`�Ύ��}�sP� ����E�H���U'e���Ћ5 �%�1M�k�p��B�Z�m������'>1�Qx��,�x�Ih�(��D�� <vVh�Ѩ��H�^e�0{t�h\D�ԕ�K
�mf��YqÊ��_H����	F�S����ڦ����a�����
l����p��q�k��-��iv��3�.�&����aj�>�� ���~Z4Wt^J�J����r�SB��^�K�J�9w�w1ujR��=*��Y�����q<���J*"-���%����tL2T <�|d�v��R��C$��'}�"o�#�t_�EWmH������c�h`�,HU��K'54x�����~8�tض?��!A����C(���Hn!hf�~/-�˟��Z@�����W,j�AJi✎-��	,.�7]nZ�sUs�/����?�e��5��p/#�      �   �   x��=N�0��S���P���hAT4/Yc,9v��b�GHI������ӛy��TTG�C����C/�#�2�j��;�8+�3z�55�s�CxC�p�L�c
|E;ml��j�scp6�C��z��&�5=�{k���oh��i�.�|Oݩ��ֆ�Wj�ꈩ�/Gp��6$�3q�:�V"E��>����ԝ�:©�I�CW���^�a�荀���I����|.ş�4�i~�`���eh      �      x������ � �      �      x������ � �     