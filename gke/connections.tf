provider "google" {
    credentials = "${file("../secrets/account.json")}"
    project     = "dummy-charged-state"
    region      = "europe-west1"
}
