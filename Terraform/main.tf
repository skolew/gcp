provider "google" {
  project     = "sportal365"
  region      = "europe-west3"
  credentials = file("keys.json")
}
