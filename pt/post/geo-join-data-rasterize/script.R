# packages
library(tidyverse)
library(sidrar)
library(geobr)
library(sf)
library(raster)
library(fasterize)

# tabular
sidrar::search_sidra("abastecimento")

sidrar::info_sidra(x = 3218)

da_agua <- sidrar::get_sidra(x = 3218,
                        variable = 1000096,
                        period = "last",
                        classific = c("c61"),
                        geo = "City")
da_agua

da_banheiro <- sidrar::get_sidra(x = 3218,
                             variable = 1000096,
                             period = "last",
                             classific = c("c299"),
                             geo = "City")
da_banheiro

da_lixo <- sidrar::get_sidra(x = 3218,
                            variable = 1000096,
                            period = "last",
                            classific = c("c67"),
                            geo = "City")
da_lixo

da_luz <- sidrar::get_sidra(x = 3218,
                             variable = 1000096,
                             period = "last",
                             classific = c("c309"),
                             geo = "City")
da_luz

# glimpse
dplyr::glimpse(da_agua)
dplyr::glimpse(da_banheiro)
dplyr::glimpse(da_lixo)
dplyr::glimpse(da_luz)

# filter and selection
da_agua_sel <- da_agua %>% 
  dplyr::filter(`Forma de abastecimento de água` == "Rede geral") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>% 
  dplyr::rename(agua_rede = Valor)

da_banheiro_sel <- da_banheiro %>% 
  dplyr::filter(`Existência de banheiro ou sanitário e esgotamento sanitário` == "Não tinham banheiro nem sanitário") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(sem_banheiro = Valor)

da_lixo_sel <- da_lixo %>% 
  dplyr::filter(`Destino do lixo` == "Coletado") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(lixo_coletado = Valor)
  
da_luz_sel <- da_luz %>% 
  dplyr::filter(`Existência de energia elétrica` == "Tinham") %>% 
  dplyr::mutate(code_muni = as.numeric(`Município (Código)`)) %>%
  dplyr::select(code_muni, Valor) %>%
  dplyr::rename(luz = Valor)

da_data <- dplyr::bind_cols(da_agua_sel, 
                            sem_banheiro = da_banheiro_sel$sem_banheiro, 
                            lixo_coletado = da_lixo_sel$lixo_coletado, 
                            luz = da_luz_sel$luz)
dplyr::glimpse(da_data)

# vetor
mun <- geobr::read_municipality(code_muni = "all", year = 2010)
mun

# join
mun_da <- dplyr::left_join(x = mun, y = da_data, by = "code_muni")
mun_da

plot(mun_da$geom)

# raster
bio <- raster::getData(name = "worldclim", var = "bio", res = 10)
bio

bio_br <- bio$bio1 %>% 
  raster::crop(mun_da) %>% 
  raster::mask(mun_da)
bio_br

plot(bio_br)

# rasterize
mun_agua_raster <- fasterize::fasterize(sf = mun_da, raster = bio_br, field = "agua_rede")
mun_agua_raster

plot(mun_agua_raster)

mun_sem_banheiro_raster <- fasterize::fasterize(sf = mun_da["sem_banheiro"], raster = bio_br, field = "sem_banheiro")
mun_sem_banheiro_raster

plot(mun_sem_banheiro_raster)

mun_lixo_raster <- fasterize::fasterize(sf = mun_da["lixo_coletado"], raster = bio_br, field = "lixo_coletado")
mun_lixo_raster

plot(mun_lixo_raster)

mun_luz_raster <- fasterize::fasterize(sf = mun_da["luz"], raster = bio_br, field = "luz")
mun_luz_raster

plot(mun_luz_raster)

tm_shape(mun_lixo_raster) +
  tm_raster(title = "Lixo") +
  tm_layout(legend.position = c("left", "bottom"))
