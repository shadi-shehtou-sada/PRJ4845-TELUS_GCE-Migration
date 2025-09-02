/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# This resource creates a new Compute Engine image by importing a VMDK file
# from a Google Cloud Storage bucket. It mirrors the functionality of the
# `gcloud compute images import` command.
resource "google_compute_image" "image_from_vmdk" {
  project = var.project_id
  name    = var.image_name
  family  = var.image_family

  # Specifies the source VMDK file in Google Cloud Storage.
  raw_disk {
    source = "gs://${var.bucket_name}/${var.vmdk_file_name}"
  }

  # Corresponds to the --byol flag, indicating you are bringing your own license.
  licenses = ["https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/byol"]

  # Sets the storage location for the final image.
  storage_locations = [var.location]

  # NOTE: The network settings for the temporary import VM (--network, --subnet, --zone)
  # are not directly configurable in this Terraform resource. The import is handled
  # by a managed Google service. To use a specific VPC, you must grant the
  # "Compute Engine Service Agent" the "Compute Network User" role on that VPC.
  # The service agent format is: service-[PROJECT_NUMBER]@compute-image-import.iam.gserviceaccount.com
}

