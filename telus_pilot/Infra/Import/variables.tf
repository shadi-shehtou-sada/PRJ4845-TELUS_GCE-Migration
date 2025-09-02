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

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project where the image will be created."
}

variable "region" {
  type        = string
  description = "The Google Cloud region for the provider."
  default     = "us-central1"
}

variable "image_name" {
  type        = string
  description = "The desired name for the new Compute Engine image."
}

variable "image_family" {
  type        = string
  description = "The family to which this image belongs."
  default     = ""
}

variable "bucket_name" {
  type        = string
  description = "The name of the Google Cloud Storage bucket containing the VMDK file."
}

variable "vmdk_file_name" {
  type        = string
  description = "The name of the VMDK file within the GCS bucket."
}

variable "location" {
  type        = string
  description = "The storage location for the image (e.g., a region like 'us-central1')."
}

# variable "network" {
#   type        = string
#   description = "The name of the VPC network to use for the temporary import VM."
# }

# variable "subnet" {
#   type        = string
#   description = "The name of the subnetwork to use for the temporary import VM."
# }

# variable "zone" {
#   type        = string
#   description = "The zone where the temporary import VM will be created (e.g., 'us-central1-a')."
# }
