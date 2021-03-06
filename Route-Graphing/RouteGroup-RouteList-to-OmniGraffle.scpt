FasdUAS 1.101.10   ��   ��    k             l      ��  ��   '! Assumes that the CSV text adheres to the convention:
    Records are delimited by LFs or CRLFs (but CRs are also allowed here).
    The last record in the text may or may not be followed by an LF or CRLF (or CR).
    Fields in the same record are separated by commas (unless specified differently by parameter).
    The last field in a record must not be followed by a comma.
    Trailing or leading spaces in unquoted fields are not ignored (unless so specified by parameter).
    Fields containing quoted text are quoted in their entirety, any space outside them being ignored.
    Fields enclosed in double-quotes are to be taken verbatim, except for any included double-quote pairs, which are to be translated as double-quote characters.
        
    No other variations are currently supported.      � 	 	B   A s s u m e s   t h a t   t h e   C S V   t e x t   a d h e r e s   t o   t h e   c o n v e n t i o n : 
         R e c o r d s   a r e   d e l i m i t e d   b y   L F s   o r   C R L F s   ( b u t   C R s   a r e   a l s o   a l l o w e d   h e r e ) . 
         T h e   l a s t   r e c o r d   i n   t h e   t e x t   m a y   o r   m a y   n o t   b e   f o l l o w e d   b y   a n   L F   o r   C R L F   ( o r   C R ) . 
         F i e l d s   i n   t h e   s a m e   r e c o r d   a r e   s e p a r a t e d   b y   c o m m a s   ( u n l e s s   s p e c i f i e d   d i f f e r e n t l y   b y   p a r a m e t e r ) . 
         T h e   l a s t   f i e l d   i n   a   r e c o r d   m u s t   n o t   b e   f o l l o w e d   b y   a   c o m m a . 
         T r a i l i n g   o r   l e a d i n g   s p a c e s   i n   u n q u o t e d   f i e l d s   a r e   n o t   i g n o r e d   ( u n l e s s   s o   s p e c i f i e d   b y   p a r a m e t e r ) . 
         F i e l d s   c o n t a i n i n g   q u o t e d   t e x t   a r e   q u o t e d   i n   t h e i r   e n t i r e t y ,   a n y   s p a c e   o u t s i d e   t h e m   b e i n g   i g n o r e d . 
         F i e l d s   e n c l o s e d   i n   d o u b l e - q u o t e s   a r e   t o   b e   t a k e n   v e r b a t i m ,   e x c e p t   f o r   a n y   i n c l u d e d   d o u b l e - q u o t e   p a i r s ,   w h i c h   a r e   t o   b e   t r a n s l a t e d   a s   d o u b l e - q u o t e   c h a r a c t e r s . 
                 
         N o   o t h e r   v a r i a t i o n s   a r e   c u r r e n t l y   s u p p o r t e d .     
  
 l     ��������  ��  ��        i         I      �� ���� 0 	csvtolist 	csvToList      o      ���� 0 csvtext csvText   ��  o      ���� 0 implementation  ��  ��    k    <       l     ��  ��   YS The 'implementation' parameter must be a record. Leave it empty ({}) for the default assumptions: ie. comma separator, leading and trailing spaces in unquoted fields not to be trimmed. Otherwise it can have a 'separator' property with a text value (eg. {separator:tab}) and/or a 'trimming' property with a boolean value ({trimming:true}).     �  �   T h e   ' i m p l e m e n t a t i o n '   p a r a m e t e r   m u s t   b e   a   r e c o r d .   L e a v e   i t   e m p t y   ( { } )   f o r   t h e   d e f a u l t   a s s u m p t i o n s :   i e .   c o m m a   s e p a r a t o r ,   l e a d i n g   a n d   t r a i l i n g   s p a c e s   i n   u n q u o t e d   f i e l d s   n o t   t o   b e   t r i m m e d .   O t h e r w i s e   i t   c a n   h a v e   a   ' s e p a r a t o r '   p r o p e r t y   w i t h   a   t e x t   v a l u e   ( e g .   { s e p a r a t o r : t a b } )   a n d / o r   a   ' t r i m m i n g '   p r o p e r t y   w i t h   a   b o o l e a n   v a l u e   ( { t r i m m i n g : t r u e } ) .      r         l     ����  b          o     ���� 0 implementation     K     ! ! �� " #�� 0 	separator   " m     $ $ � % %  , # �� &���� 0 trimming   & m    ��
�� boovfals��  ��  ��    K       ' ' �� ( )�� 0 	separator   ( o      ���� 0 	separator   ) �� *���� 0 trimming   * o      ���� 0 trimming  ��     + , + l   ��������  ��  ��   ,  - . - h    �� /�� 0 o   / l      0 1 2 0 k       3 3  4 5 4 j     �� 6�� 0 qdti   6 I     �� 7���� 0 gettextitems getTextItems 7  8 9 8 o    ���� 0 csvtext csvText 9  :�� : m     ; ; � < <  "��  ��   5  = > = j    �� ?�� 0 currentrecord currentRecord ? J    ����   >  @ A @ j    �� B��  0 possiblefields possibleFields B m    ��
�� 
msng A  C�� C j    �� D�� 0 
recordlist 
recordList D J    ����  ��   1   Lists for fast access.    2 � E E .   L i s t s   f o r   f a s t   a c c e s s . .  F G F l   ��������  ��  ��   G  H I H l   �� J K��   J Q K o's qdti is a list of the CSV's text items, as delimited by double-quotes.    K � L L �   o ' s   q d t i   i s   a   l i s t   o f   t h e   C S V ' s   t e x t   i t e m s ,   a s   d e l i m i t e d   b y   d o u b l e - q u o t e s . I  M N M l   �� O P��   O R L Assuming the convention mentioned above, the number of items is always odd.    P � Q Q �   A s s u m i n g   t h e   c o n v e n t i o n   m e n t i o n e d   a b o v e ,   t h e   n u m b e r   o f   i t e m s   i s   a l w a y s   o d d . N  R S R l   �� T U��   T S M Even-numbered items (if any) are quoted field values and don't need parsing.    U � V V �   E v e n - n u m b e r e d   i t e m s   ( i f   a n y )   a r e   q u o t e d   f i e l d   v a l u e s   a n d   d o n ' t   n e e d   p a r s i n g . S  W X W l   �� Y Z��   Y R L Odd-numbered items are everything else. Empty strings in odd-numbered slots    Z � [ [ �   O d d - n u m b e r e d   i t e m s   a r e   e v e r y t h i n g   e l s e .   E m p t y   s t r i n g s   i n   o d d - n u m b e r e d   s l o t s X  \ ] \ l   �� ^ _��   ^ R L (except at the beginning and end) indicate escaped quotes in quoted fields.    _ � ` ` �   ( e x c e p t   a t   t h e   b e g i n n i n g   a n d   e n d )   i n d i c a t e   e s c a p e d   q u o t e s   i n   q u o t e d   f i e l d s . ]  a b a l   ��������  ��  ��   b  c d c r    # e f e n   ! g h g 1    !��
�� 
txdl h 1    ��
�� 
ascr f o      ���� 	0 astid   d  i j i r   $ - k l k l  $ + m���� m I  $ +�� n��
�� .corecnte****       **** n n  $ ' o p o o   % '���� 0 qdti   p o   $ %���� 0 o  ��  ��  ��   l o      ���� 0 	qdticount 	qdtiCount j  q r q r   . 1 s t s m   . /��
�� boovfals t o      ���� "0 quoteinprogress quoteInProgress r  u v u P   2 w x�� w Y   7 y�� z { | y l  A } ~  } k   A � �  � � � r   A I � � � n   A G � � � 4   D G�� �
�� 
cobj � o   E F���� 0 i   � n  A D � � � o   B D���� 0 qdti   � o   A B���� 0 o   � o      ���� 0 thisbit thisBit �  ��� � Z   J � � ��� � G   J Y � � � l  J Q ����� � ?   J Q � � � l  J O ����� � I  J O�� ���
�� .corecnte****       **** � o   J K���� 0 thisbit thisBit��  ��  ��   � m   O P����  ��  ��   � l  T W ����� � =  T W � � � o   T U���� 0 i   � o   U V���� 0 	qdticount 	qdtiCount��  ��   � k   \� � �  � � � l  \ \�� � ���   � T N This is either a non-empty string or the last item in the list, so it doesn't    � � � � �   T h i s   i s   e i t h e r   a   n o n - e m p t y   s t r i n g   o r   t h e   l a s t   i t e m   i n   t h e   l i s t ,   s o   i t   d o e s n ' t �  � � � l  \ \�� � ���   � K E represent a quoted quote. Check if we've just been dealing with any.    � � � � �   r e p r e s e n t   a   q u o t e d   q u o t e .   C h e c k   i f   w e ' v e   j u s t   b e e n   d e a l i n g   w i t h   a n y . �  � � � Z   \ � � � ��� � l  \ ] ����� � o   \ ]���� "0 quoteinprogress quoteInProgress��  ��   � k   ` � � �  � � � l  ` `�� � ���   � M G All the parts of a quoted field containing quoted quotes have now been    � � � � �   A l l   t h e   p a r t s   o f   a   q u o t e d   f i e l d   c o n t a i n i n g   q u o t e d   q u o t e s   h a v e   n o w   b e e n �  � � � l  ` `�� � ���   � A ; passed over. Coerce them together using a quote delimiter.    � � � � v   p a s s e d   o v e r .   C o e r c e   t h e m   t o g e t h e r   u s i n g   a   q u o t e   d e l i m i t e r . �  � � � r   ` e � � � m   ` a � � � � �  " � n      � � � 1   b d��
�� 
txdl � 1   a b��
�� 
ascr �  � � � r   f y � � � c   f w � � � l  f u ����� � n   f u � � � 7  i u�� � �
�� 
cobj � o   m o���� 0 a   � l  p t ����� � \   p t � � � o   q r���� 0 i   � m   r s���� ��  ��   � n  f i � � � o   g i���� 0 qdti   � o   f g���� 0 o  ��  ��   � m   u v��
�� 
TEXT � o      ���� 0 	thisfield 	thisField �  � � � l  z z�� � ���   � C = Replace the reconstituted quoted quotes with literal quotes.    � � � � z   R e p l a c e   t h e   r e c o n s t i t u t e d   q u o t e d   q u o t e s   w i t h   l i t e r a l   q u o t e s . �  � � � r   z � � � � m   z } � � � � �  " " � n      � � � 1   ~ ���
�� 
txdl � 1   } ~��
�� 
ascr �  � � � r   � � � � � n  � � � � � 2  � ���
�� 
citm � o   � ����� 0 	thisfield 	thisField � o      ���� 0 	thisfield 	thisField �  � � � r   � � � � � m   � � � � � � �  " � n      � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr �  � � � l  � ��� � ���   � \ V Store the field in the "current record" list and cancel the "quote in progress" flag.    � � � � �   S t o r e   t h e   f i e l d   i n   t h e   " c u r r e n t   r e c o r d "   l i s t   a n d   c a n c e l   t h e   " q u o t e   i n   p r o g r e s s "   f l a g . �  � � � r   � � � � � c   � � � � � o   � ����� 0 	thisfield 	thisField � m   � ���
�� 
TEXT � n       � � �  ;   � � � n  � � � � � o   � ����� 0 currentrecord currentRecord � o   � ����� 0 o   �  ��� � r   � � � � � m   � ���
�� boovfals � o      ���� "0 quoteinprogress quoteInProgress��   �  � � � l  � � ����� � ?   � � � � � o   � ����� 0 i   � m   � ����� ��  ��   �  ��� � k   � � � �    l  � �����   N H The preceding, even-numbered item is a complete quoted field. Store it.    � �   T h e   p r e c e d i n g ,   e v e n - n u m b e r e d   i t e m   i s   a   c o m p l e t e   q u o t e d   f i e l d .   S t o r e   i t . �� r   � � n   � �	 4   � ��

� 
cobj
 l  � ��~�} \   � � o   � ��|�| 0 i   m   � ��{�{ �~  �}  	 n  � � o   � ��z�z 0 qdti   o   � ��y�y 0 o   n        ;   � � n  � � o   � ��x�x 0 currentrecord currentRecord o   � ��w�w 0 o  ��  ��  ��   �  l  � ��v�u�t�v  �u  �t    l  � ��s�s  60 Now parse this item's field-separator-delimited text items, which are either non-quoted fields or stumps from the removal of quoted fields. Any that contain line breaks must be further split to end one record and start another. These could include multiple single-field records without field separators.    �`   N o w   p a r s e   t h i s   i t e m ' s   f i e l d - s e p a r a t o r - d e l i m i t e d   t e x t   i t e m s ,   w h i c h   a r e   e i t h e r   n o n - q u o t e d   f i e l d s   o r   s t u m p s   f r o m   t h e   r e m o v a l   o f   q u o t e d   f i e l d s .   A n y   t h a t   c o n t a i n   l i n e   b r e a k s   m u s t   b e   f u r t h e r   s p l i t   t o   e n d   o n e   r e c o r d   a n d   s t a r t   a n o t h e r .   T h e s e   c o u l d   i n c l u d e   m u l t i p l e   s i n g l e - f i e l d   r e c o r d s   w i t h o u t   f i e l d   s e p a r a t o r s .  r   � � I   � ��r�q�r 0 gettextitems getTextItems  !  o   � ��p�p 0 thisbit thisBit! "�o" o   � ��n�n 0 	separator  �o  �q   n     #$# o   � ��m�m  0 possiblefields possibleFields$ o   � ��l�l 0 o   %&% r   � �'(' l  � �)�k�j) I  � ��i*�h
�i .corecnte****       ***** n  � �+,+ o   � ��g�g  0 possiblefields possibleFields, o   � ��f�f 0 o  �h  �k  �j  ( o      �e�e (0 possiblefieldcount possibleFieldCount& -.- Y   ��/�d01�c/ k   ��22 343 r   � �565 n   � �787 4   � ��b9
�b 
cobj9 o   � ��a�a 0 j  8 n  � �:;: o   � ��`�`  0 possiblefields possibleFields; o   � ��_�_ 0 o  6 o      �^�^ 0 	thisfield 	thisField4 <�]< Z   ��=>�\?= l  � �@�[�Z@ ?   � �ABA l  � �C�Y�XC I  � ��WDE
�W .corecnte****       ****D o   � ��V�V 0 	thisfield 	thisFieldE �UF�T
�U 
koclF m   � ��S
�S 
cpar�T  �Y  �X  B m   � ��R�R �[  �Z  > k   ��GG HIH l  � ��QJK�Q  J P J This "field" contains one or more line endings. Split it at those points.   K �LL �   T h i s   " f i e l d "   c o n t a i n s   o n e   o r   m o r e   l i n e   e n d i n g s .   S p l i t   i t   a t   t h o s e   p o i n t s .I MNM r   �OPO n  �QRQ 2  ��P
�P 
cparR o   � ��O�O 0 	thisfield 	thisFieldP o      �N�N 0 thesefields theseFieldsN STS l �MUV�M  U � � With each of these end-of-record fields except the last, complete the field list for the current record and initialise another. Omit the first "field" if it's just the stub from a preceding quoted field.   V �WW�   W i t h   e a c h   o f   t h e s e   e n d - o f - r e c o r d   f i e l d s   e x c e p t   t h e   l a s t ,   c o m p l e t e   t h e   f i e l d   l i s t   f o r   t h e   c u r r e n t   r e c o r d   a n d   i n i t i a l i s e   a n o t h e r .   O m i t   t h e   f i r s t   " f i e l d "   i f   i t ' s   j u s t   t h e   s t u b   f r o m   a   p r e c e d i n g   q u o t e d   f i e l d .T XYX Y  pZ�L[\�KZ k  k]] ^_^ r  `a` n  bcb 4  �Jd
�J 
cobjd o  �I�I 0 k  c o  �H�H 0 thesefields theseFieldsa o      �G�G 0 	thisfield 	thisField_ efe Z Ugh�F�Eg l @i�D�Ci G  @jkj G  .lml G  &non l p�B�Ap ?  qrq o  �@�@ 0 k  r m  �?�? �B  �A  o l !$s�>�=s ?  !$tut o  !"�<�< 0 j  u m  "#�;�; �>  �=  m l ),v�:�9v = ),wxw o  )*�8�8 0 i  x m  *+�7�7 �:  �9  k l 1>y�6�5y ?  1>z{z l 1<|�4�3| I 1<�2}�1
�2 .corecnte****       ****} I  18�0~�/�0 0 trim  ~ � o  23�.�. 0 	thisfield 	thisField� ��-� m  34�,
�, boovtrue�-  �/  �1  �4  �3  { m  <=�+�+  �6  �5  �D  �C  h r  CQ��� I  CJ�*��)�* 0 trim  � ��� o  DE�(�( 0 	thisfield 	thisField� ��'� o  EF�&�& 0 trimming  �'  �)  � n      ���  ;  OP� n JO��� o  KO�%�% 0 currentrecord currentRecord� o  JK�$�$ 0 o  �F  �E  f ��� r  Vb��� n V[��� o  W[�#�# 0 currentrecord currentRecord� o  VW�"�" 0 o  � n      ���  ;  `a� n [`��� o  \`�!�! 0 
recordlist 
recordList� o  [\� �  0 o  � ��� r  ck��� J  ce��  � n     ��� o  fj�� 0 currentrecord currentRecord� o  ef�� 0 o  �  �L 0 k  [ m  �� \ \  ��� l ���� I ���
� .corecnte****       ****� o  	�� 0 thesefields theseFields�  �  �  � m  �� �K  Y ��� l qq����  � � � With the last end-of-record "field", just complete the current field list if the field's not the stub from a following quoted field.   � ���
   W i t h   t h e   l a s t   e n d - o f - r e c o r d   " f i e l d " ,   j u s t   c o m p l e t e   t h e   c u r r e n t   f i e l d   l i s t   i f   t h e   f i e l d ' s   n o t   t h e   s t u b   f r o m   a   f o l l o w i n g   q u o t e d   f i e l d .� ��� r  qu��� n  qs���  ;  rs� o  qr�� 0 thesefields theseFields� o      �� 0 	thisfield 	thisField� ��� Z v������ l v����� G  v���� l vy���� A  vy��� o  vw�
�
 0 j  � o  wx�	�	 (0 possiblefieldcount possibleFieldCount�  �  � l |����� ?  |���� l |����� I |����
� .corecnte****       ****� o  |}�� 0 	thisfield 	thisField�  �  �  � m  ����  �  �  �  �  � r  ����� I  ��� ����  0 trim  � ��� o  ������ 0 	thisfield 	thisField� ���� o  ������ 0 trimming  ��  ��  � n      ���  ;  ��� n ����� o  ������ 0 currentrecord currentRecord� o  ������ 0 o  �  �  �  �\  ? k  ���� ��� l ��������  � � � This is a "field" not containing a line break. Insert it into the current field list if it's not just a stub from a preceding or following quoted field.   � ���2   T h i s   i s   a   " f i e l d "   n o t   c o n t a i n i n g   a   l i n e   b r e a k .   I n s e r t   i t   i n t o   t h e   c u r r e n t   f i e l d   l i s t   i f   i t ' s   n o t   j u s t   a   s t u b   f r o m   a   p r e c e d i n g   o r   f o l l o w i n g   q u o t e d   f i e l d .� ���� Z ��������� l �������� G  ����� G  ����� l �������� F  ����� l �������� ?  ����� o  ������ 0 j  � m  ������ ��  ��  � l �������� G  ����� l �������� A  ����� o  ������ 0 j  � o  ������ (0 possiblefieldcount possibleFieldCount��  ��  � l �������� = ����� o  ������ 0 i  � o  ������ 0 	qdticount 	qdtiCount��  ��  ��  ��  ��  ��  � l �������� F  ����� l �������� = ����� o  ������ 0 j  � m  ������ ��  ��  � l �������� = ����� o  ������ 0 i  � m  ������ ��  ��  ��  ��  � l �������� ?  ����� l �������� I �������
�� .corecnte****       ****� I  ��������� 0 trim  � ��� o  ������ 0 	thisfield 	thisField� ���� m  ����
�� boovtrue��  ��  ��  ��  ��  � m  ������  ��  ��  ��  ��  � r  ����� I  ��������� 0 trim  � ��� o  ������ 0 	thisfield 	thisField� ���� o  ������ 0 trimming  ��  ��  � n      ���  ;  ��� n ����� o  ������ 0 currentrecord currentRecord� o  ������ 0 o  ��  ��  ��  �]  �d 0 j  0 m   � ����� 1 o   � ����� (0 possiblefieldcount possibleFieldCount�c  . ��� l ����������  ��  ��  � ���� l ��������  � I C Otherwise, this item IS an empty text representing a quoted quote.   � �   �   O t h e r w i s e ,   t h i s   i t e m   I S   a n   e m p t y   t e x t   r e p r e s e n t i n g   a   q u o t e d   q u o t e .��   �  l ������ o  ������ "0 quoteinprogress quoteInProgress��  ��    l ������   Z T It's another quote in a field already identified as having one. Do nothing for now.    � �   I t ' s   a n o t h e r   q u o t e   i n   a   f i e l d   a l r e a d y   i d e n t i f i e d   a s   h a v i n g   o n e .   D o   n o t h i n g   f o r   n o w . 	
	 l ������ ?  �� o  ������ 0 i   m  ������ ��  ��  
 �� k  �  l ������   K E It's the first quoted quote in a quoted field. Note the index of the    � �   I t ' s   t h e   f i r s t   q u o t e d   q u o t e   i n   a   q u o t e d   f i e l d .   N o t e   t h e   i n d e x   o f   t h e  l ������   T N preceding even-numbered item (the first part of the field) and flag "quote in    � �   p r e c e d i n g   e v e n - n u m b e r e d   i t e m   ( t h e   f i r s t   p a r t   o f   t h e   f i e l d )   a n d   f l a g   " q u o t e   i n  l ������   R L progress" so that the repeat idles past the remaining part(s) of the field.    � �   p r o g r e s s "   s o   t h a t   t h e   r e p e a t   i d l e s   p a s t   t h e   r e m a i n i n g   p a r t ( s )   o f   t h e   f i e l d .   r  �!"! \  �#$# o  � ���� 0 i  $ m   ���� " o      ���� 0 a    %��% r  &'& m  ��
�� boovtrue' o      ���� "0 quoteinprogress quoteInProgress��  ��  ��  ��   ~ %  Parse odd-numbered items only.     �(( >   P a r s e   o d d - n u m b e r e d   i t e m s   o n l y .�� 0 i   z m   : ;����  { o   ; <���� 0 	qdticount 	qdtiCount | m   < =����  x ����
�� conscase��  ��   v )*) l ��������  ��  ��  * +,+ l ��-.��  - F @ At the end of the repeat, store any remaining "current record".   . �// �   A t   t h e   e n d   o f   t h e   r e p e a t ,   s t o r e   a n y   r e m a i n i n g   " c u r r e n t   r e c o r d " ., 010 Z .23����2 l 4����4 > 565 n 787 o  ���� 0 currentrecord currentRecord8 o  ���� 0 o  6 J  ����  ��  ��  3 r  *9:9 n #;<; o  #���� 0 currentrecord currentRecord< o  ���� 0 o  : n      =>=  ;  ()> n #(?@? o  $(���� 0 
recordlist 
recordList@ o  #$���� 0 o  ��  ��  1 ABA r  /4CDC o  /0���� 	0 astid  D n     EFE 1  13��
�� 
txdlF 1  01��
�� 
ascrB GHG l 55��������  ��  ��  H I��I L  5<JJ n 5;KLK o  6:���� 0 
recordlist 
recordListL o  56���� 0 o  ��    MNM l     ��������  ��  ��  N OPO l     ��QR��  Q > 8 Get the possibly more than 4000 text items from a text.   R �SS p   G e t   t h e   p o s s i b l y   m o r e   t h a n   4 0 0 0   t e x t   i t e m s   f r o m   a   t e x t .P TUT i    VWV I      ��X���� 0 gettextitems getTextItemsX YZY o      ���� 0 txt  Z [��[ o      ���� 	0 delim  ��  ��  W k     V\\ ]^] r     _`_ n    aba 1    ��
�� 
txdlb 1     ��
�� 
ascr` o      ���� 	0 astid  ^ cdc r    efe o    ���� 	0 delim  f n     ghg 1    
��
�� 
txdlh 1    ��
�� 
ascrd iji r    klk l   m����m I   �n�~
� .corecnte****       ****n n   opo 2   �}
�} 
citmp o    �|�| 0 txt  �~  ��  ��  l o      �{�{ 0 ticount tiCountj qrq r    sts J    �z�z  t o      �y�y 0 	textitems 	textItemsr uvu Y    Mw�xxyzw k   % H{{ |}| r   % *~~ [   % (��� o   % &�w�w 0 i  � m   & '�v�v� o      �u�u 0 j  } ��� Z  + 8���t�s� l  + .��r�q� ?   + .��� o   + ,�p�p 0 j  � o   , -�o�o 0 ticount tiCount�r  �q  � r   1 4��� o   1 2�n�n 0 ticount tiCount� o      �m�m 0 j  �t  �s  � ��l� r   9 H��� b   9 F��� o   9 :�k�k 0 	textitems 	textItems� n   : E��� 7  ; E�j��
�j 
citm� o   ? A�i�i 0 i  � o   B D�h�h 0 j  � o   : ;�g�g 0 txt  � o      �f�f 0 	textitems 	textItems�l  �x 0 i  x m    �e�e y o     �d�d 0 ticount tiCountz m     !�c�c�v ��� r   N S��� o   N O�b�b 	0 astid  � n     ��� 1   P R�a
�a 
txdl� 1   O P�`
�` 
ascr� ��� l  T T�_�^�]�_  �^  �]  � ��\� L   T V�� o   T U�[�[ 0 	textitems 	textItems�\  U ��� l     �Z�Y�X�Z  �Y  �X  � ��� l     �W���W  � 9 3 Trim any leading or trailing spaces from a string.   � ��� f   T r i m   a n y   l e a d i n g   o r   t r a i l i n g   s p a c e s   f r o m   a   s t r i n g .� ��� i    ��� I      �V��U�V 0 trim  � ��� o      �T�T 0 txt  � ��S� o      �R�R 0 trimming  �S  �U  � k     r�� ��� Z     o���Q�P� l    ��O�N� o     �M�M 0 trimming  �O  �N  � k    k�� ��� Y    0��L���K� Z    +���J�� l   ��I�H� C   ��� o    �G�G 0 txt  � 1    �F
�F 
spac�I  �H  � r    '��� n    %��� 7   %�E��
�E 
ctxt� m    !�D�D � m   " $�C�C��� o    �B�B 0 txt  � o      �A�A 0 txt  �J  �  S   * +�L 0 i  � m    �@�@ � \    ��� l   ��?�>� I   �=��<
�= .corecnte****       ****� o    	�;�; 0 txt  �<  �?  �>  � m    �:�: �K  � ��� Y   1 ]��9���8� Z   A X���7�� l  A D��6�5� D   A D��� o   A B�4�4 0 txt  � 1   B C�3
�3 
spac�6  �5  � r   G T��� n   G R��� 7  H R�2��
�2 
ctxt� m   L N�1�1 � m   O Q�0�0��� o   G H�/�/ 0 txt  � o      �.�. 0 txt  �7  �  S   W X�9 0 i  � m   4 5�-�- � \   5 <��� l  5 :��,�+� I  5 :�*��)
�* .corecnte****       ****� o   5 6�(�( 0 txt  �)  �,  �+  � m   : ;�'�' �8  � ��&� Z  ^ k���%�$� l  ^ a��#�"� =  ^ a��� o   ^ _�!�! 0 txt  � 1   _ `� 
�  
spac�#  �"  � r   d g��� m   d e�� ���  � o      �� 0 txt  �%  �$  �&  �Q  �P  � ��� l  p p����  �  �  � ��� L   p r�� o   p q�� 0 txt  �  � ��� l     ����  �  �  � ��� i    ��� I      ���� 0 	drawshape 	drawShape� ��� o      �� 0 
objectname 
objectName� ��� o      �� 0 textsize textSize� ��� o      �� 0 xloc xLoc� ��� o      �� 0 yloc yLoc� ��� o      �� 0 boxwsize boxWSize� ��� o      �� 0 boxlsize boxLSize� � � o      �� 0 colorr colorR   o      �� 0 colorg colorG � o      �� 0 colorb colorB�  �  � k     x  O     u O    t	
	 r    s I   q�
�	
�
 .corecrel****      � null�	   �
� 
kocl m    �
� 
OGSh �
� 
insh n      ;     2   �
� 
OGGr ��
� 
prdt K    k �
� 
Oggn o    �� 0 
objectname 
objectName � 
�  
Ogcr m    ����  ��
�� 
Ogds m     ��
�� boovfals ��
�� 
ptsz J   ! %   o   ! "���� 0 boxwsize boxWSize  !��! o   " #���� 0 boxlsize boxLSize��   ��"#
�� 
ctxt" K   & L$$ ��%&
�� 
ptsz% 1   ' ,��
�� 
Otss& ��'(
�� 
OTta' m   / 2��
�� OGhaOTa1( ��)*
�� 
colr) J   5 @++ ,-, m   5 8..         - /0/ m   8 ;11         0 2��2 m   ; >33         ��  * ��45
�� 
font4 m   C F66 �77  H e l v e t i c a N e u e5 ��8��
�� 
ctxt8 o   G H���� 0 
objectname 
objectName��  # ��9:
�� 
Ogtp9 m   O R��
�� OGvaOGv0: ��;<
�� 
Ogor; J   U Y== >?> o   U V���� 0 xloc xLoc? @��@ o   V W���� 0 yloc yLoc��  < ��AB
�� 
OGSJA m   \ _��
�� OGSJOGbeB ��C��
�� 
OgfcC J   b gDD EFE o   b c���� 0 colorr colorRF GHG o   c d���� 0 colorg colorGH I��I o   d e���� 0 colorb colorB��  ��  �   o      ����  0 objectlocation objectLocation
 n    JKJ m    ��
�� 
OGWSK 4   ��L
�� 
cwinL m   
 ����  5     ��M��
�� 
cappM m    NN �OO 4 c o m . o m n i g r o u p . O m n i G r a f f l e 7
�� kfrmID   P��P L   v xQQ o   v w����  0 objectlocation objectLocation��  � RSR l     ��������  ��  ��  S TUT i    VWV I      ��X���� 0 drawlink drawLinkX YZY o      ���� 0 
firstshape 
firstShapeZ [��[ o      ���� 0 secondshape secondShape��  ��  W O     #\]\ O    "^_^ I   !��`a
�� .OGSSOGCoOGLi       obj ` o    ���� 0 
firstshape 
firstShapea ��bc
�� 
inshb o    ���� 0 secondshape secondShapec ��d��
�� 
prdtd K    ee ��fg
�� 
Olltf m    ��
�� OGLTOGL1g ��hi
�� 
OGHth m    ��
�� OGHTOGH1i ��j��
�� 
Olhtj m    kk �ll  F i l l e d A r r o w��  ��  _ n    mnm m    ��
�� 
OGWSn 4   ��o
�� 
cwino m   
 ���� ] 5     ��p��
�� 
cappp m    qq �rr 4 c o m . o m n i g r o u p . O m n i G r a f f l e 7
�� kfrmID  U sts l     ��������  ��  ��  t uvu l    w����w r     xyx J     ����  y o      ���� 0 	shapedict 	shapeDict��  ��  v z{z l     ��������  ��  ��  { |}| i    ~~ I      ������� 0 locateshape locateShape� ��� o      ���� 0 	shapename 	shapeName� ���� o      ���� 0 	shapedict 	shapeDict��  ��   X     (����� Z    #������� =   ��� n    ��� o    ���� 0 listitem ListItem� o    ���� 0 thisshapename thisShapeName� o    ���� 0 	shapename 	shapeName� k    �� ��� L    �� n    ��� o    ���� 0 listloc ListLoc� o    ���� 0 thisshapename thisShapeName� ����  S    ��  ��  ��  �� 0 thisshapename thisShapeName� o    ���� 0 	shapedict 	shapeDict} ��� l     ��������  ��  ��  � ��� i    ��� I      ������� 0 readfile readFile� ���� o      ���� 0 thefile theFile��  ��  � k     �� ��� l     ������  � #  Convert the file to a string   � ��� :   C o n v e r t   t h e   f i l e   t o   a   s t r i n g� ��� r     ��� c     ��� o     ���� 0 thefile theFile� m    ��
�� 
TEXT� o      ���� 0 thefile theFile� ��� l   ��������  ��  ��  � ��� l   ������  � , & Read the file and return its contents   � ��� L   R e a d   t h e   f i l e   a n d   r e t u r n   i t s   c o n t e n t s� ���� L    �� I   �����
�� .rdwrread****        ****� 4    
���
�� 
file� o    	���� 0 thefile theFile��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l   ������ r    ��� I   �����
�� .sysostdfalis    ��� null��  � ����
�� 
ftyp� m    �� ���  c s v� �����
�� 
prmp� m   	 
�� ��� Z P l e a s e   s e l e c t   G a t e w a y / T r u n k   c s v   f i l e   t o   r e a d :��  � o      ���� 0 thefile1 theFile1��  ��  � ��� l   ������ I    ������� 0 readfile readFile� ��� o    �~�~ 0 thefile1 theFile1�  ��  ��  ��  � ��� l   #��}�|� r    #��� I   !�{�z�
�{ .sysostdfalis    ��� null�z  � �y��
�y 
ftyp� m    �� ���  c s v� �x��w
�x 
prmp� m    �� ��� V P l e a s e   s e l e c t   R o u t e   G r o u p   c s v   f i l e   t o   r e a d :�w  � o      �v�v 0 thefile2 theFile2�}  �|  � ��� l  $ *��u�t� I   $ *�s��r�s 0 readfile readFile� ��q� o   % &�p�p 0 thefile2 theFile2�q  �r  �u  �t  � ��� l  + 6��o�n� r   + 6��� I  + 4�m�l�
�m .sysostdfalis    ��� null�l  � �k��
�k 
ftyp� m   - .�� ���  c s v� �j��i
�j 
prmp� m   / 0�� ��� T P l e a s e   s e l e c t   R o u t e   L i s t   c s v   f i l e   t o   r e a d :�i  � o      �h�h 0 thefile3 theFile3�o  �n  � ��� l  7 =��g�f� I   7 =�e��d�e 0 readfile readFile� ��c� o   8 9�b�b 0 thefile3 theFile3�c  �d  �g  �f  � ��� l     �a�`�_�a  �`  �_  � ��� l  > A��^�]� r   > A��� m   > ?�\
�\ boovfals� o      �[�[ 0 link  �^  �]  � ��� l     �Z�Y�X�Z  �Y  �X  � ��� l  B L��W�V� r   B L��� I   B H�U��T�U 0 readfile readFile� ��S� o   C D�R�R 0 thefile1 theFile1�S  �T  � o      �Q�Q 0 csvtext1 csvText1�W  �V  � ��� l  M [��P�O� r   M [� � I   M W�N�M�N 0 	csvtolist 	csvToList  o   N Q�L�L 0 csvtext1 csvText1 �K J   Q S�J�J  �K  �M    o      �I�I 0 allobjects1  �P  �O  �  l  \ f�H�G r   \ f	 I   \ b�F
�E�F 0 readfile readFile
 �D o   ] ^�C�C 0 thefile2 theFile2�D  �E  	 o      �B�B 0 csvtext2 csvText2�H  �G    l  g u�A�@ r   g u I   g q�?�>�? 0 	csvtolist 	csvToList  o   h k�=�= 0 csvtext2 csvText2 �< J   k m�;�;  �<  �>   o      �:�: 0 allobjects2  �A  �@    l  v ��9�8 r   v � I   v |�7�6�7 0 readfile readFile �5 o   w x�4�4 0 thefile3 theFile3�5  �6   o      �3�3 0 csvtext3 csvText3�9  �8    l  � ��2�1 r   � �  I   � ��0!�/�0 0 	csvtolist 	csvToList! "#" o   � ��.�. 0 csvtext3 csvText3# $�-$ J   � ��,�,  �-  �/    o      �+�+ 0 allobjects3  �2  �1   %&% l     �*�)�(�*  �)  �(  & '(' l     �')*�'  )   First File   * �++    F i r s t   F i l e( ,-, l  � �.�&�%. r   � �/0/ m   � ��$�$  0 o      �#�# 0 	spacedown 	spaceDown�&  �%  - 121 l  ��3�"�!3 Y   ��4� 56�4 k   ��77 898 r   � �:;: n   � �<=< 4   � ��>
� 
cobj> o   � ��� 0 a  = o   � ��� 0 allobjects1  ; o      �� (0 thecurrentlistitem theCurrentListItem9 ?@? r   � �ABA ]   � �CDC l  � �E��E I  � ��F�
� .corecnte****       ****F o   � ��� (0 thecurrentlistitem theCurrentListItem�  �  �  D m   � ��� #B o      �� 0 
bigboxsize 
bigBoxSize@ GHG r   � �IJI [   � �KLK o   � ��� 0 	spacedown 	spaceDownL m   � ��� #J o      �� 0 	spacedown 	spaceDownH MNM Y   ��O�PQ�O k   �{RR STS r   � �UVU n   � �WXW 4   � ��Y
� 
cobjY o   � ��� 0 b  X o   � ��� (0 thecurrentlistitem theCurrentListItemV o      ��  0 secondlistitem secondListItemT Z[Z Z   �o\]�
^\ =   � �_`_ o   � ��	�	 0 b  ` m   � ��� ] k   �4aa bcb r   � �ded o   � ��� 0 	spacedown 	spaceDowne o      �� 0 	firstitem 	firstItemc fgf r   �"hih I   ��j�� 0 	drawshape 	drawShapej klk o   � ��  0 secondlistitem secondListIteml mnm m   �� n opo m  qq @�@     p rsr o  	�� 0 	spacedown 	spaceDowns tut m  	vv @t      u wxw o  � �  0 
bigboxsize 
bigBoxSizex yzy m  {{ ?�|\�P��z |}| m  ~~ ?�|� y��} �� m  �� ?�|q�1r��  �  i o      ���� 0 
firstshape 
firstShapeg ���� r  #4��� K  #1�� ������ 0 listitem ListItem� o  &)����  0 secondlistitem secondListItem� ������� 0 listloc ListLoc� o  ,/���� 0 
firstshape 
firstShape��  � n      ���  ;  23� o  12���� 0 	shapedict 	shapeDict��  �
  ^ k  7o�� ��� r  7]��� I  7Y������� 0 	drawshape 	drawShape� ��� o  8;����  0 secondlistitem secondListItem� ��� m  ;>���� � ��� m  >A�� @�h     � ��� o  AD���� 0 	spacedown 	spaceDown� ��� m  DG�� @r�     � ��� m  GJ�� @9      � ��� m  JM�� ?ݑ����� ��� m  MP�� ?��8��Rr� ���� m  PS�� ?�      ��  ��  � o      ���� 0 newshape newShape� ���� r  ^o��� K  ^l�� ������ 0 listitem ListItem� o  ad����  0 secondlistitem secondListItem� ������� 0 listloc ListLoc� o  gj���� 0 newshape newShape��  � n      ���  ;  mn� o  lm���� 0 	shapedict 	shapeDict��  [ ���� r  p{��� [  pw��� o  ps���� 0 	spacedown 	spaceDown� m  sv���� #� o      ���� 0 	spacedown 	spaceDown��  � 0 b  P m   � ����� Q n   � ���� 1   � ���
�� 
leng� o   � ����� (0 thecurrentlistitem theCurrentListItem�  N ���� r  ����� m  ����
�� boovfals� o      ���� 0 link  ��  �  0 a  5 m   � ����� 6 n   � ���� 1   � ���
�� 
leng� o   � ����� 0 allobjects1  �  �"  �!  2 ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �   Second File   � ���    S e c o n d   F i l e� ��� l �������� r  ����� m  ������  � o      ���� 0 	spacedown 	spaceDown��  ��  � ��� l �������� Y  ���������� k  ���� ��� r  ����� n  ����� 4  �����
�� 
cobj� o  ������ 0 a  � o  ������ 0 allobjects2  � o      ���� (0 thecurrentlistitem theCurrentListItem� ��� r  ����� ]  ����� l �������� I �������
�� .corecnte****       ****� o  ������ (0 thecurrentlistitem theCurrentListItem��  ��  ��  � m  ������ #� o      ���� 0 
bigboxsize 
bigBoxSize� ��� r  ����� [  ����� o  ������ 0 	spacedown 	spaceDown� m  ������ #� o      ���� 0 	spacedown 	spaceDown� ��� Y  ���������� k  ���� ��� r  ����� n  ����� 4  �����
�� 
cobj� o  ������ 0 b  � o  ������ (0 thecurrentlistitem theCurrentListItem� o      ����  0 secondlistitem secondListItem� ��� Z  ������� =  ����� o  ������ 0 b  � m  ������ � k  �.�� ��� r  ����� o  ������ 0 	spacedown 	spaceDown� o      ���� 0 	firstitem 	firstItem�    r  � I  ������� 0 	drawshape 	drawShape  o  ������  0 secondlistitem secondListItem  m  ������  	
	 m  �  @�@     
  o   ���� 0 	spacedown 	spaceDown  m   @t        o  	���� 0 
bigboxsize 
bigBoxSize  m  	 ?�|\�P��  m   ?�|� y�� �� m   ?�|q�1r��  ��   o      ���� 0 
firstshape 
firstShape �� r  . K  + �� �� 0 listitem ListItem o   #����  0 secondlistitem secondListItem  ��!���� 0 listloc ListLoc! o  &)���� 0 
firstshape 
firstShape��   n      "#"  ;  ,-# o  +,���� 0 	shapedict 	shapeDict��  � $%$ =  14&'& o  12���� 0 b  ' m  23���� % (��( r  7])*) I  7Y��+���� 0 	drawshape 	drawShape+ ,-, o  8;����  0 secondlistitem secondListItem- ./. m  ;>���� / 010 m  >A22 @��     1 343 o  AD���� 0 	spacedown 	spaceDown4 565 m  DG77 @r�     6 898 m  GJ:: @9      9 ;<; m  JM== ?ݑ����< >?> m  MP@@ ?��8��Rr? A��A m  PSBB ?�      ��  ��  * o      ���� 0 newshape newShape��  � k  `�CC DED l ``��FG��  F  
 shapeDict   G �HH    s h a p e D i c tE IJI r  `mKLK I  `i��M���� 0 locateshape locateShapeM NON o  ad����  0 secondlistitem secondListItemO P��P o  de���� 0 	shapedict 	shapeDict��  ��  L o      ���� $0 endpointtwofile2 endpointTwoFile2J QRQ r  n�STS I  n���U���� 0 	drawshape 	drawShapeU VWV o  or����  0 secondlistitem secondListItemW XYX m  ru���� Y Z[Z m  ux\\ @��     [ ]^] o  x{���� 0 	spacedown 	spaceDown^ _`_ m  {~aa @r�     ` bcb m  ~�dd @9      c efe m  ��gg ?ݑ����f hih m  ��jj ?��8��Rri k��k m  ��ll ?�      ��  ��  T o      ���� 0 newshape newShapeR mnm Q  ��op��o Z  ��qr����q > ��sts o  ������ $0 endpointtwofile2 endpointTwoFile2t m  ����
�� 
msngr I  ����u���� 0 drawlink drawLinku vwv o  ������ 0 newshape newShapew x��x o  ������ $0 endpointtwofile2 endpointTwoFile2��  ��  ��  ��  p R      ������
�� .ascrerr ****      � ****��  ��  ��  n y��y r  ��z{z K  ��|| �}~� 0 listitem ListItem} o  ���~�~  0 secondlistitem secondListItem~ �}�|�} 0 listloc ListLoc o  ���{�{ 0 newshape newShape�|  { n      ���  ;  ��� o  ���z�z 0 	shapedict 	shapeDict��  � ��y� r  ����� [  ����� o  ���x�x 0 	spacedown 	spaceDown� m  ���w�w #� o      �v�v 0 	spacedown 	spaceDown�y  �� 0 b  � m  ���u�u � n  ����� 1  ���t
�t 
leng� o  ���s�s (0 thecurrentlistitem theCurrentListItem��  � ��r� r  ����� m  ���q
�q boovfals� o      �p�p 0 link  �r  �� 0 a  � m  ���o�o � n  ����� 1  ���n
�n 
leng� o  ���m�m 0 allobjects2  ��  ��  ��  � ��� l     �l�k�j�l  �k  �j  � ��� l     �i���i  �   Third File   � ���    T h i r d   F i l e� ��� l ����h�g� r  ����� m  ���f�f  � o      �e�e 0 	spacedown 	spaceDown�h  �g  � ��� l ���d�c� Y  ���b���a� k  ��� ��� r  �
��� n  ���� 4  �`�
�` 
cobj� o  �_�_ 0 a  � o  ��^�^ 0 allobjects3  � o      �]�] (0 thecurrentlistitem theCurrentListItem� ��� r  ��� ]  ��� l ��\�[� I �Z��Y
�Z .corecnte****       ****� o  �X�X (0 thecurrentlistitem theCurrentListItem�Y  �\  �[  � m  �W�W #� o      �V�V 0 
bigboxsize 
bigBoxSize� ��� r  &��� [  "��� o  �U�U 0 	spacedown 	spaceDown� m  !�T�T #� o      �S�S 0 	spacedown 	spaceDown� ��� Y  '��R���Q� k  8�� ��� r  8D��� n  8@��� 4  ;@�P�
�P 
cobj� o  >?�O�O 0 b  � o  8;�N�N (0 thecurrentlistitem theCurrentListItem� o      �M�M  0 secondlistitem secondListItem� ��� Z  E����L�� =  EH��� o  EF�K�K 0 b  � m  FG�J�J � k  K��� ��� r  KR��� o  KN�I�I 0 	spacedown 	spaceDown� o      �H�H 0 	firstitem 	firstItem� ��� r  Sy��� I  Su�G��F�G 0 	drawshape 	drawShape� ��� o  TW�E�E  0 secondlistitem secondListItem� ��� m  WZ�D�D � ��� m  Z]�� @$      � ��� o  ]`�C�C 0 	spacedown 	spaceDown� ��� m  `c�� @t      � ��� o  cf�B�B 0 
bigboxsize 
bigBoxSize� ��� m  fi�� ?�|\�P��� ��� m  il�� ?�|� y��� ��A� m  lo�� ?�|q�1r�A  �F  � o      �@�@ 0 
firstshape 
firstShape� ��?� r  z���� K  z��� �>���> 0 listitem ListItem� o  }��=�=  0 secondlistitem secondListItem� �<��;�< 0 listloc ListLoc� o  ���:�: 0 
firstshape 
firstShape�;  � n      ���  ;  ��� o  ���9�9 0 	shapedict 	shapeDict�?  �L  � k  ���� ��� r  ����� I  ���8��7�8 0 locateshape locateShape� ��� o  ���6�6  0 secondlistitem secondListItem� ��5� o  ���4�4 0 	shapedict 	shapeDict�5  �7  � o      �3�3 $0 endpointtwofile3 endpointTwoFile3� ��� r  ����� I  ���2 �1�2 0 	drawshape 	drawShape   o  ���0�0  0 secondlistitem secondListItem  m  ���/�/   m  �� @4       	 o  ���.�. 0 	spacedown 	spaceDown	 

 m  �� @r�       m  �� @9        m  �� ?ݑ����  m  �� ?��8��Rr �- m  �� ?�      �-  �1  � o      �,�, 0 newshape newShape�  Q  ���+ Z  ���*�) > �� o  ���(�( $0 endpointtwofile3 endpointTwoFile3 m  ���'
�' 
msng I  ���& �%�& 0 drawlink drawLink  !"! o  ���$�$ 0 newshape newShape" #�## o  ���"�" $0 endpointtwofile3 endpointTwoFile3�#  �%  �*  �)   R      �!� �
�! .ascrerr ****      � ****�   �  �+   $�$ r  ��%&% K  ��'' �()� 0 listitem ListItem( o  ����  0 secondlistitem secondListItem) �*�� 0 listloc ListLoc* o  ���� 0 newshape newShape�  & n      +,+  ;  ��, o  ���� 0 	shapedict 	shapeDict�  � -�- r  �./. [  �010 o  ���� 0 	spacedown 	spaceDown1 m  ��� #/ o      �� 0 	spacedown 	spaceDown�  �R 0 b  � m  *+�� � n  +3232 1  .2�
� 
leng3 o  +.�� (0 thecurrentlistitem theCurrentListItem�Q  � 4�4 r  565 m  �
� boovfals6 o      �� 0 link  �  �b 0 a  � m  ���� � n  ��787 1  ���
� 
leng8 o  ���� 0 allobjects3  �a  �d  �c  � 9:9 l     �
�	��
  �	  �  : ;<; l =��= o  �� 0 	shapedict 	shapeDict�  �  < >�> l     ����  �  �  �       
� ?@ABCDEFG�   ? ������������������ 0 	csvtolist 	csvToList�� 0 gettextitems getTextItems�� 0 trim  �� 0 	drawshape 	drawShape�� 0 drawlink drawLink�� 0 locateshape locateShape�� 0 readfile readFile
�� .aevtoappnull  �   � ****@ �� ����HI���� 0 	csvtolist 	csvToList�� ��J�� J  ������ 0 csvtext csvText�� 0 implementation  ��  H ���������������������������������� 0 csvtext csvText�� 0 implementation  �� 0 	separator  �� 0 trimming  �� 0 o  �� 	0 astid  �� 0 	qdticount 	qdtiCount�� "0 quoteinprogress quoteInProgress�� 0 i  �� 0 thisbit thisBit�� 0 a  �� 0 	thisfield 	thisField�� (0 possiblefieldcount possibleFieldCount�� 0 j  �� 0 thesefields theseFields�� 0 k  I �� $������ /K�������� x���� ��� ��� ����������������� 0 	separator  �� 0 trimming  �� �� 0 o  K ��L����MN��
�� .ascrinit****      � ****L k     OO  4PP  =QQ  @RR  C����  ��  ��  M ���������� 0 qdti  �� 0 currentrecord currentRecord��  0 possiblefields possibleFields�� 0 
recordlist 
recordListN  ;�������������� 0 gettextitems getTextItems�� 0 qdti  �� 0 currentrecord currentRecord
�� 
msng��  0 possiblefields possibleFields�� 0 
recordlist 
recordList�� *b   �l+ �Ojv�O�Ojv�
�� 
ascr
�� 
txdl�� 0 qdti  
�� .corecnte****       ****
�� 
cobj
�� 
bool
�� 
TEXT
�� 
citm�� 0 currentrecord currentRecord�� 0 gettextitems getTextItems��  0 possiblefields possibleFields
�� 
kocl
�� 
cpar�� 0 trim  �� 0 
recordlist 
recordList��=����f�%E[�,E�Z[�,E�ZO��K S�O��,E�O��,j 
E�OfE�O�g��k�lh ��,�/E�O�j 
j
 �� �&�� E���,FO��,[�\[Z�\Z�k2�&E�Oa ��,FO�a -E�Oa ��,FO��&�a ,6FOfE�Y �k ��,�k/�a ,6FY hO*��l+ �a ,FO�a ,j 
E�Ok�kh �a ,�/E�O�a a l 
k ��a -E�O kk�j 
kkh ��/E�O�k
 �k�&
 �k �&
 *�el+ j 
j�& *��l+ �a ,6FY hO�a ,�a ,6FOjv�a ,F[OY��O�6E�O��
 �j 
j�& *��l+ �a ,6FY hY L�k	 ��
 �� �&�&
 �k 	 �k �&�&
 *�el+ j 
j�& *��l+ �a ,6FY h[OY��OPY � hY �k �kE�OeE�Y h[OY�/VO�a ,jv �a ,�a ,6FY hO���,FO�a ,EA ��W����ST���� 0 gettextitems getTextItems�� ��U�� U  ������ 0 txt  �� 	0 delim  ��  S ���������������� 0 txt  �� 	0 delim  �� 	0 astid  �� 0 ticount tiCount�� 0 	textitems 	textItems�� 0 i  �� 0 j  T ������������
�� 
ascr
�� 
txdl
�� 
citm
�� .corecnte****       ****�������� W��,E�O���,FO��-j E�OjvE�O 1k��h ��E�O�� �E�Y hO��[�\[Z�\Z�2%E�[OY��O���,FO�B �������VW���� 0 trim  �� ��X�� X  ������ 0 txt  �� 0 trimming  ��  V �������� 0 txt  �� 0 trimming  �� 0 i  W ���������
�� .corecnte****       ****
�� 
spac
�� 
ctxt������ s� l +k�j  kkh �� �[�\[Zl\Zi2E�Y [OY��O +k�j  kkh �� �[�\[Zk\Z�2E�Y [OY��O��  �E�Y hY hO�C �������YZ���� 0 	drawshape 	drawShape�� ��[�� 	[ 	 �������������������� 0 
objectname 
objectName�� 0 textsize textSize�� 0 xloc xLoc�� 0 yloc yLoc�� 0 boxwsize boxWSize�� 0 boxlsize boxLSize�� 0 colorr colorR�� 0 colorg colorG�� 0 colorb colorB��  Y 
���������������������� 0 
objectname 
objectName�� 0 textsize textSize�� 0 xloc xLoc�� 0 yloc yLoc�� 0 boxwsize boxWSize�� 0 boxlsize boxLSize�� 0 colorr colorR�� 0 colorg colorG�� 0 colorb colorB��  0 objectlocation objectLocationZ !��N����������~�}�|�{�z�y�x�w�v�u�t�s�r.�q6�p�o�n�m�l�k�j�i�h�g
�� 
capp
�� kfrmID  
�� 
cwin
�� 
OGWS
�� 
kocl
� 
OGSh
�~ 
insh
�} 
OGGr
�| 
prdt
�{ 
Oggn
�z 
Ogcr�y 
�x 
Ogds
�w 
ptsz
�v 
ctxt
�u 
Otss
�t 
OTta
�s OGhaOTa1
�r 
colr
�q 
font�p 

�o 
Ogtp
�n OGvaOGv0
�m 
Ogor
�l 
OGSJ
�k OGSJOGbe
�j 
Ogfc�i �h 
�g .corecrel****      � null�� y)���0 n*�k/�, d*���*�-6�����flv��*a ,a a a a a a mva a �a a a a ��lva a a ���mva a   E�UUO�D �fW�e�d\]�c�f 0 drawlink drawLink�e �b^�b ^  �a�`�a 0 
firstshape 
firstShape�` 0 secondshape secondShape�d  \ �_�^�_ 0 
firstshape 
firstShape�^ 0 secondshape secondShape] �]q�\�[�Z�Y�X�W�V�U�T�Sk�R�Q�P
�] 
capp
�\ kfrmID  
�[ 
cwin
�Z 
OGWS
�Y 
insh
�X 
prdt
�W 
Ollt
�V OGLTOGL1
�U 
OGHt
�T OGHTOGH1
�S 
Olht�R �Q 
�P .OGSSOGCoOGLi       obj �c $)���0 *�k/�, ����������� UUE �O�N�M_`�L�O 0 locateshape locateShape�N �Ka�K a  �J�I�J 0 	shapename 	shapeName�I 0 	shapedict 	shapeDict�M  _ �H�G�F�H 0 	shapename 	shapeName�G 0 	shapedict 	shapeDict�F 0 thisshapename thisShapeName` �E�D�C�B�A
�E 
kocl
�D 
cobj
�C .corecnte****       ****�B 0 listitem ListItem�A 0 listloc ListLoc�L ) '�[��l kh ��,�  ��,EOY h[OY��F �@��?�>bc�=�@ 0 readfile readFile�? �<d�< d  �;�; 0 thefile theFile�>  b �:�: 0 thefile theFilec �9�8�7
�9 
TEXT
�8 
file
�7 .rdwrread****        ****�= ��&E�O*�/j G �6e�5�4fg�3
�6 .aevtoappnull  �   � ****e k    hh uii �jj �kk �ll �mm �nn �oo �pp �qq �rr ss tt uu vv ,ww 1xx �yy �zz �{{ �|| ;�2�2  �5  �4  f �1�0�1 0 a  �0 0 b  g >�/�.��-��,�+�*�)���(���'�&�%�$�#�"�!� �����������qv{~��������������2����
�	����/ 0 	shapedict 	shapeDict
�. 
ftyp
�- 
prmp�, 
�+ .sysostdfalis    ��� null�* 0 thefile1 theFile1�) 0 readfile readFile�( 0 thefile2 theFile2�' 0 thefile3 theFile3�& 0 link  �% 0 csvtext1 csvText1�$ 0 	csvtolist 	csvToList�# 0 allobjects1  �" 0 csvtext2 csvText2�! 0 allobjects2  �  0 csvtext3 csvText3� 0 allobjects3  � 0 	spacedown 	spaceDown
� 
leng
� 
cobj� (0 thecurrentlistitem theCurrentListItem
� .corecnte****       ****� #� 0 
bigboxsize 
bigBoxSize�  0 secondlistitem secondListItem� 0 	firstitem 	firstItem� � 	� 0 	drawshape 	drawShape� 0 
firstshape 
firstShape� 0 listitem ListItem� 0 listloc ListLoc� � 0 newshape newShape� 0 locateshape locateShape� $0 endpointtwofile2 endpointTwoFile2
� 
msng�
 0 drawlink drawLink�	  �  � $0 endpointtwofile3 endpointTwoFile3�3jvE�O*����� E�O*�k+ O*����� E�O*�k+ O*����� E�O*�k+ OfE�O*�k+ E` O*_ jvl+ E` O*�k+ E` O*_ jvl+ E` O*�k+ E` O*_ jvl+ E` OjE` O �k_ a ,Ekh  _ a �/E` O_ j a  E` O_ a E` O �k_ a ,Ekh _ a �/E` O�k  E_ E` O*_ a  a !_ a "_ a #a $a %a &+ 'E` (Oa )_ a *_ (��6FY :*_ a +a ,_ a -a .a /a 0a 1a &+ 'E` 2Oa )_ a *_ 2��6FO_ a E` [OY�`OfE�[OY�OjE` OUk_ a ,Ekh  _ a �/E` O_ j a  E` O_ a E` Ok_ a ,Ekh _ a �/E` O�k  E_ E` O*_ a  a 3_ a "_ a #a $a %a &+ 'E` (Oa )_ a *_ (��6FY ��l  +*_ a +a 4_ a -a .a /a 0a 1a &+ 'E` 2Y n*_ �l+ 5E` 6O*_ a +a 4_ a -a .a /a 0a 1a &+ 'E` 2O _ 6a 7 *_ 2_ 6l+ 8Y hW X 9 :hOa )_ a *_ 2��6FO_ a E` [OY��OfE�[OY��OjE` O&k_ a ,Ekh  _ a �/E` O_ j a  E` O_ a E` O �k_ a ,Ekh _ a �/E` O�k  E_ E` O*_ a  a ;_ a "_ a #a $a %a &+ 'E` (Oa )_ a *_ (��6FY n*_ �l+ 5E` <O*_ a +a =_ a -a .a /a 0a 1a &+ 'E` 2O _ <a 7 *_ 2_ <l+ 8Y hW X 9 :hOa )_ a *_ 2��6FO_ a E` [OY�,OfE�[OY��O�ascr  ��ޭ