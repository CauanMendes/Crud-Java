/*
 * SGBD: MySQL
 * 
 * Este arquivo contém:
 * - Definição da estrutura do banco de dados `loja` (tabelas).
 * - Massa de dados para testes.
 * - Exemplos de consultas. 
 */

DROP DATABASE IF EXISTS loja;
CREATE DATABASE loja;
USE loja;


-- tabelas

create table produto (
	id int not null auto_increment,
	descricao varchar(200) not null,
	preco double(7, 2) not null,
	primary key (id)
);

create table cliente (
	id int not null auto_increment,
	nome varchar(40) not null,
	email varchar(80),
	ativo boolean default true,
	primary key (id)
);

create table pedido (
	id int not null auto_increment,
	cliente_id int not null,
	dt_criacao datetime not null,
	primary key (id)
);
alter table pedido add constraint fk_cliente foreign key (cliente_id) references cliente(id);

create table pedido_item (
	id int not null auto_increment,
	pedido_id int not null,
	produto_id int not null,
	quantidade int not null,
	primary key (id)
);
alter table pedido_item add constraint fk_pedido foreign key (pedido_id) references pedido(id);
alter table pedido_item add constraint fk_produto foreign key (produto_id) references produto(id);
alter table pedido_item add constraint ck_quantidade check (quantidade > 0);



-- dados de teste --

-- produtos
insert into produto (id, descricao, preco) values (1, 'Kit Teclado e Mouse Sem Fio Dell Pro, 4000 DPI, ABNT2, Preto', 199.99);
insert into produto (id, descricao, preco) values (2, 'Combo Teclado e Mouse sem fio Logitech MK220 com Design Compacto, Conexão USB, Pilhas Inclusas e Layout ABNT2', 169.99);
insert into produto (id, descricao, preco) values (3, 'Headset Gamer Sem Fio Logitech G Pro X 2 Lightspeed, Driver 50mm, Bluetooth, USB e 3.5mm, para PC, Playstation e Switch, Preto', 1449.99);
insert into produto (id, descricao, preco) values (4, 'Mesa Digitalizadora Huion Kamvas 13, USB, Cosmo Black, Preto', 1599.99);
insert into produto (id, descricao, preco) values (5, 'Combo Teclado e Mouse sem fio Logitech MK470 com Design Slim, Digitação e Clique Silencioso, Mouse Ambidestro e Pilhas Inclusas', 252.86);
insert into produto (id, descricao, preco) values (6, 'Mesa Digitalizadora Huion Kamvas Plus 22", Tela Full HD, Caneta PenTech 3.0, 8192 Níveis de Pressão, com Luva de Desenho, Preto', 3489.99);
insert into produto (id, descricao, preco) values (7, 'Teclado e Mouse Logitech MK540 Advanced Sem Fio Multimídia Tecnologia Unifying Cinza ABNT2', 288.90);
insert into produto (id, descricao, preco) values (8, 'Mouse Gamer Sem Fio Logitech G703 LIGHTSPEED RGB LIGHTSYNC, 6 Botões Programáveis, HERO 25K, Recarregável, Compatível POWERPLAY', 439.99);
insert into produto (id, descricao, preco) values (9, 'Headset Gamer Havit, Drivers 53mm,  Microfone Plugável, 3.5mm, PC, PS4, XBOX ONE, Preto', 159.99);
insert into produto (id, descricao, preco) values (10, 'Mouse Gamer Redragon Cobra, Chroma RGB, 12400 DPI, 8 Botões, Preto', 89.99);
insert into produto (id, descricao, preco) values (11, 'Headset Gamer Sem Fio Havit Fuxi H3, 7.1 surround, Driver 40mm, Bluetooth e USB, Preto', 169.99);
insert into produto (id, descricao, preco) values (12, 'Mouse Gamer Sem Fio Logitech G305 LIGHTSPEED, 12000 DPI, 6 Botões, Preto', 199.99);
insert into produto (id, descricao, preco) values (13, 'Suporte de Mesa Articulado para Monitor de 17" a 32" Ergofirst, Ajuste com Pistão a Gás, Preto', 99.99);
insert into produto (id, descricao, preco) values (14, 'Mouse Gamer Sem Fio Redragon Invader Pro, RGB, 10000 DPI, 8 Botões, Wireless, Preto', 99.99);
insert into produto (id, descricao, preco) values (15, 'Headset HP DHH', 39.90);
insert into produto (id, descricao, preco) values (16, 'Mouse Sem Fio AOC MS200, 1200 DPI, 3 Botões, Design Ergonômico, Preto', 19.99);
insert into produto (id, descricao, preco) values (17, 'Headset com fio USB Logitech H390 com Almofadas, Controles de Áudio Integrado e Microfone com Redução de Ruído', 209.99);
insert into produto (id, descricao, preco) values (18, 'Mousepad Gamer Husky Black Frost, Speed, Extra Grande (900x400mm), Preto', 32.99);
insert into produto (id, descricao, preco) values (19, 'Teclado com fio USB Logitech K120 Resistente à Respingos e Layout ABNT2', 65.99);
insert into produto (id, descricao, preco) values (20, 'Mousepad Maxprint, Pequeno, 220x178mm, Preto', 3.99);
insert into produto (id, descricao, preco) values (21, 'Suporte de Mesa Articulado para Monitor de 17" a 32" North Bayou, Ajustes com Pistão a Gás, Grafite', 119.99);
insert into produto (id, descricao, preco) values (22, 'Teclado e Mouse Sem Fio Dell KM3322W, USB, ABNT2, Preto', 142.99);
insert into produto (id, descricao, preco) values (23, 'Mouse Gamer Sem Fio Attack Shark X11, 22000 Dpi, 59g, Tri', 179.91);
insert into produto (id, descricao, preco) values (24, 'Teclado Semi', 42.99);
insert into produto (id, descricao, preco) values (25, 'Headset Gamer Redragon Zeus X, Chroma Mk.II, RGB, Som Surround 7.1, Drivers 53mm, USB, Preto e Vermelho', 279.99);
insert into produto (id, descricao, preco) values (26, 'Combo Teclado e Mouse sem fio Logitech MK235 com Conexão USB, Pilhas Inclusas e Layout ABNT2', 145.99);
insert into produto (id, descricao, preco) values (27, 'Combo Teclado e Mouse com fio USB Logitech MK120 com Design Confortável, Durável e Resistente à Respingos e Layout ABNT2', 99.99);
insert into produto (id, descricao, preco) values (28, 'Mouse com fio USB Logitech M90 com Design Ambidestro e Facilidade Plug and Play', 34.90);
insert into produto (id, descricao, preco) values (29, 'Teclado e Mouse Rise Mode Office OF 01, USB, ABNT2, Preto', 33.99);
insert into produto (id, descricao, preco) values (30, 'Mousepad Gamer Rise Mode RGB, Estendido (900x300mm), Preto', 34.99);
insert into produto (id, descricao, preco) values (31, 'Mouse Gamer Sem Fio Redragon Invader Pro, RGB, 10000 DPI, 8 Botões, Wireless, Branco', 124.99);
insert into produto (id, descricao, preco) values (32, 'Gabinete Gamer Redragon Wideload Lite, Mid Tower, ATX, Lateral em Vidro Temperado, Preto', 279.99);
insert into produto (id, descricao, preco) values (33, 'Microfone de Mesa Fifine A6V Ampligame, com Suporte, Condensador, RGB, USB, Preto', 149.99);
insert into produto (id, descricao, preco) values (34, 'Gabinete Gamer Rise Mode Glass 06X, Mid Tower, ATX, Lateral em Vidro Fumê e Frontal em Vidro Temperado, Sem FANs, Preto', 139.99);
insert into produto (id, descricao, preco) values (35, 'Headset Gamer Sem Fio Redragon Zeus Pro, 7.1, Driver 53mm, Bluetooth, Preto', 317.99);
insert into produto (id, descricao, preco) values (36, 'Teclado Sem Fio Mecânico Gamer Redragon Kumara Pro, RGB, Switch Brown, ABNT2, Anti', 219.99);
insert into produto (id, descricao, preco) values (37, 'Gabinete Gamer Rise Mode Galaxy Glass M Mini, M', 179.99);
insert into produto (id, descricao, preco) values (38, 'Mouse sem fio Logitech M170 com Design Ambidestro Compacto, Conexão USB e Pilha Inclusa, Preto', 59.90);
insert into produto (id, descricao, preco) values (39, 'Teclado Mecânico Gamer Machenike K500', 135.99);
insert into produto (id, descricao, preco) values (40, 'Suporte de Notebook Ajustável Alumínio, Leve, Resistente, Durável', 15.90);
insert into produto (id, descricao, preco) values (41, 'Suporte Octoo UpTable p/ Notebook  Preto Fosco', 35.90);
insert into produto (id, descricao, preco) values (42, 'Gabinete Gamer Rise Mode Wave Black, Mid Tower, Lateral em Vidro Fumê, ARGB, ATX, 3 Cooler Fan ARGB, Preto', 184.99);
insert into produto (id, descricao, preco) values (43, 'Mouse Gamer Sem Fio Attack Shark X11, 22000 Dpi, 59g, Tri', 179.91);
insert into produto (id, descricao, preco) values (44, 'Teclado Magnético Gamer Rise Mode GM1 Pro, ARGB, Magnético OTK PRO, USB', 199.99);
insert into produto (id, descricao, preco) values (45, 'Mousepad Reliza Compact, com Apoio de Pulso, Preto', 8.99);
insert into produto (id, descricao, preco) values (46, 'Kit Teclado e Mouse HP 150, USB', 79.99);
insert into produto (id, descricao, preco) values (47, 'Mouse Gamer Sem Fio Logitech G Pro X Superlight 2 com Lightspeed, 32000 DPI, Sensor Hero 2, com Bateria Recarregável, Preto', 749.90);
insert into produto (id, descricao, preco) values (48, 'Gabinete Gamer Rise Mode Galaxy Glass M Mini, M', 179.99);
insert into produto (id, descricao, preco) values (49, 'Suporte de Parede Articulado para Monitor de 17" a 32" Ergofirst, Ajuste com Pistão a Gás, Preto', 79.99);
insert into produto (id, descricao, preco) values (50, 'Mouse Gamer Sem Fio Logitech G305 Lightspeed, 12.000 DPI, 6 Botões Programáveis, Branco', 199.99);
insert into produto (id, descricao, preco) values (51, 'Teclado Gamer Redragon Lakshmi, Switch Brown,  Layout 60%, ABNT2, Preto', 135.99);
insert into produto (id, descricao, preco) values (52, 'Suporte de Mesa Articulado para 2 Monitores de 17" a 32" Ergofirst, Ajuste com Pistão a Gás, Preto', 169.99);
insert into produto (id, descricao, preco) values (53, 'Mouse Gamer Logitech G203 LIGHTSYNC RGB, Efeito de Ondas de Cores, 6 Botões Programáveis e Até 8.000 DPI, Preto', 98.89);
insert into produto (id, descricao, preco) values (54, 'Cabo HDMI 2.0 4K PIX, 2 Metros, 19 Pinos', 12.99);
insert into produto (id, descricao, preco) values (55, 'Teclado Magnético Gamer Attack Shark X68 HE, Rapid Trigger, 8000Hz, 0.01mm, 65%, Black, Preto', 289.99);
insert into produto (id, descricao, preco) values (56, 'Headset Trust Ayda, Microfone Rebatível, Design Leve, Para PC, Conexão USB, Preto', 129.90);
insert into produto (id, descricao, preco) values (57, 'Teclado Mecânico Gamer Redragon Kumara, Anti', 149.99);
insert into produto (id, descricao, preco) values (58, 'Kit Teclado e Mouse Sem Fio AOC 2.4G Wireless Set, Preto', 77.99);
insert into produto (id, descricao, preco) values (59, 'Suporte de Mesa Articulado para Monitores de 17" a 35", ELG, Ajuste de altura com Pistão a Gás', 179.99);
insert into produto (id, descricao, preco) values (60, 'Gabinete Gamer Kalkan Asgard, Mid Tower, ATX, Lateral em Vidro Temperado, Preto', 279.99);
insert into produto (id, descricao, preco) values (61, 'Headset Poly Blackwire 3220 Stereo, USB', 219.90);
insert into produto (id, descricao, preco) values (62, 'Gabinete Gamer Hyrax HGB210, Mid Tower, ATX,  Lateral e Frontal em Vidro Temperado, Sem Fans, Preto', 119.99);
insert into produto (id, descricao, preco) values (63, 'Gabinete Office Rise Mode X1 Black, Mini Tower, M', 69.99);
insert into produto (id, descricao, preco) values (64, 'Mouse Gamer Sem Fio Redragon King 4K Pro, Wireless, 26000 DPI, 7 Botões, Preto', 238.90);
insert into produto (id, descricao, preco) values (65, 'Mouse Gamer com Fio Attack Shark X11, Ultraleve, 12.800 DPI, 5 Botões', 109.99);
insert into produto (id, descricao, preco) values (66, 'Mouse Pad Multi Desk Pad, Extra Grande, 70x30, Preto', 22.99);
insert into produto (id, descricao, preco) values (67, 'Teclado Semi Mecânico Gamer Rise Mode G1 Full, Membrana, USB, Preto', 33.99);
insert into produto (id, descricao, preco) values (68, 'Teclado Mecânico Gamer Machenike K500B', 159.99);
insert into produto (id, descricao, preco) values (69, 'Gabinete Gamer Rise Mode Galaxy Glass Standard V2, Mid Tower, ATX, Lateral e Frontal em Vidro Temperado, Com 10 Ventoinhas, Preto', 529.99);
insert into produto (id, descricao, preco) values (70, 'Gabinete Kalkan Midgard, Mid Tower, Lateral em Vidro, Micro', 199.99);
insert into produto (id, descricao, preco) values (71, 'Base com Cooler para Notebook Rise Mode, Galaxy Black X4, LED', 32.99);
insert into produto (id, descricao, preco) values (72, 'Gabinete Gamer Corsair 480T Airflow, Mid', 279.99);
insert into produto (id, descricao, preco) values (73, 'Headset Gamer Sem Fio Corsair Void Elite Wireless, RGB, Surround 7.1, Drivers 50mm, Carbono', 549.99);
insert into produto (id, descricao, preco) values (74, 'Suporte de Mesa Articulado para Monitor de 17" a 35" ELG, com Pistão a Gás e Cabo HDMI 2.0, VESA, Grafite', 159.99);
insert into produto (id, descricao, preco) values (75, 'Headset Gamer Redragon Zeus Lite, P3, Preto', 179.99);
insert into produto (id, descricao, preco) values (76, 'Teclado Semi Mecânico Gamer Rise Mode G1 Full, Membrana, USB, Branco', 27.99);
insert into produto (id, descricao, preco) values (77, 'Kit Teclado e Mouse HP Sem Fio, 1.600 DPI, Wireless, 3 Botões, ABNT, USB, Preto', 119.99);
insert into produto (id, descricao, preco) values (78, 'Headset HP DHE', 41.99);
insert into produto (id, descricao, preco) values (79, 'Teclado Magnético Gamer Attack Shark X82 HE, 75%, Rapid Trigger, 8000Hz, 0.01mm, Contour Line, Preto e Cinza', 279.99);
insert into produto (id, descricao, preco) values (80, 'Gabinete Office Husky 100, Micro ATX, Mini ATX, Preto', 59.99);
insert into produto (id, descricao, preco) values (81, 'Gabinete Gamer Montech X3 Mesh, Mid', 299.90);
insert into produto (id, descricao, preco) values (82, 'Gabinete Gamer Rise Mode Galaxy Glass X Mini, M', 144.99);
insert into produto (id, descricao, preco) values (83, 'Apoio Ergonômico para os pés Multivisão, MDF, Preto, Desmontado', 44.99);
insert into produto (id, descricao, preco) values (84, 'Headset Logitech H390, Controles de Áudio Integrado, Microfone com Redução de Ruído, USB', 189.99);
insert into produto (id, descricao, preco) values (85, 'Mousepad Gamer Havit Control, Extra Grande (900x300mm), Preto', 24.99);
insert into produto (id, descricao, preco) values (86, 'Webcam Full HD Logitech C920s com Microfone Embutido, Proteção de Privacidade, Widescreen 1080p, Compatível Logitech Capture', 399.99);
insert into produto (id, descricao, preco) values (87, 'Base com Cooler para Notebook Rise Mode, 17", Galaxy Black X3, RGB, USB', 66.99);
insert into produto (id, descricao, preco) values (88, 'Teclado Mecânico Gamer Razer BlackWidow V3, Chroma RGB, Switch Green, Edição Especial, Layout US', 379.99);
insert into produto (id, descricao, preco) values (89, 'Headset Gamer Sem Fio Corsair HS80 RGB, Dolby Atmos, Drivers 50mm, Wireless, Branco', 599.99);
insert into produto (id, descricao, preco) values (90, 'Mousepad Gamer Rise Mode Black Mode, Speed, Estendido (900x300mm)', 29.99);
insert into produto (id, descricao, preco) values (91, 'Mouse sem fio Logitech M280 com Conexão USB e Pilha Inclusa, Preto', 84.99);
insert into produto (id, descricao, preco) values (92, 'Mouse Gamer Sem Fio Razer Viper V3 HyperSpeed, 30000 DPI, Preto', 429.99);
insert into produto (id, descricao, preco) values (93, 'Gabinete Gamer Rise Mode Glass 06x, Mid Tower, ARGB, ATX, Lateral e Frente em Vidro, 6x Fans, Preto', 254.99);
insert into produto (id, descricao, preco) values (94, 'Webcam Rise Mode Vision 2K, 30 FPS, Microfone Digital, USB, Preto', 139.99);
insert into produto (id, descricao, preco) values (95, 'Headset Gamer Sem Fio Corsair HS80 Premium, RGB, Surround, Dolby Atmos, Wireless, Drivers 50mm, Preto', 959.99);
insert into produto (id, descricao, preco) values (96, 'Microfone de Mesa Fifine A8 Ampligame, com Suporte, Condensador, RGB, USB, para Streaming, PC, PS4 e PS5, Preto', 219.99);
insert into produto (id, descricao, preco) values (97, 'Kit Teclado e Mouse AOC KM170, USB, ABNT2, Preto, W2CH7TSNH', 41.99);
insert into produto (id, descricao, preco) values (98, 'Headset Gamer HyperX Cloud Stinger 2 Core, Drivers 40mm, Preto', 279.99);
insert into produto (id, descricao, preco) values (99, 'Teclado Mecânico Gamer Redragon Kumara, Anti', 179.99);
insert into produto (id, descricao, preco) values (100, 'Mouse Gamer Corsair Scimitar Elite, RGB, 17 Botões, 18000DPI, Preto', 349.99);
insert into produto (id, descricao, preco) values (101, 'Headset Gamer Com Fio Quantum 100m2 Jbl Com Mic, Preto', 178.99);
insert into produto (id, descricao, preco) values (102, 'Teclado Mecânico Gamer Husky Sled, TKL, Preto, ABNT2, RGB, Switch Gateron G Pro Red', 239.99);
insert into produto (id, descricao, preco) values (103, 'Gabinete Office Rise Mode X1 White, Mini Tower, M', 86.99);
insert into produto (id, descricao, preco) values (104, 'Mousepad Gamer Logitech G G240, Pequeno 340x280mm, Atrito Moderado, Preto', 59.90);
insert into produto (id, descricao, preco) values (105, 'Mouse Gamer Force One Lynx, 19.000 DPI, RGB, Switchs Hotswap, Personalizável, Dual Mode Wireless ou Wired USB', 299.99);
insert into produto (id, descricao, preco) values (106, 'Webcam HD Logitech C270, 720p, 30 FPS, Microfone Integrado, USB 2.0', 199.90);

-- clientes
insert into cliente (id, nome, email) values (1, 'Juvenal Junqueira', 'juvenal@freemail.com');
insert into cliente (id, nome, email) values (2, 'Mário Martins', 'mario@freemail.com');
insert into cliente (id, nome, email) values (3, 'Norberto Nogueira', 'norberto@freemail.com');

-- pedido com itens
insert into pedido (id, cliente_id, dt_criacao) values (1, 1, now());
insert into pedido_item(id, pedido_id, produto_id, quantidade) values (1, 1, 1, 2);
insert into pedido_item(id, pedido_id, produto_id, quantidade) values (2, 1, 2, 1);
insert into pedido_item(id, pedido_id, produto_id, quantidade) values (3, 1, 3, 3);

