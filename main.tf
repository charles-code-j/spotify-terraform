terraform {
  required_providers {
    spotify = {
      version = "0.2.7"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.spotify_api_key
}

data "spotify_search_track" "by_artist" {
  artist = "Skrillex"
  limit = 10
}

data "spotify_search_track" "post_malone" {
  artist = "Post Malone"
  limit = 10
}

data "spotify_search_track" "grupo_revelacao" {
  artist = "Grupo Revelação"
  limit = 10
}

data "spotify_search_track" "falamansa" {
  artist = "Falamansa"
  limit = 10
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Playlist"
  description = "This playlist was created by Terraform"
  public      = true
  

  tracks = flatten([
    data.spotify_search_track.by_artist.tracks[*].id,
    data.spotify_search_track.post_malone.tracks[*].id,
    data.spotify_search_track.grupo_revelacao.tracks[*].id, 
    data.spotify_search_track.falamansa.tracks[*].id
  ])

}
