resource "aws_dynamodb_table" "Test_dynamodb" {
  name                = var.name
  billing_mode        = var.billing_mode
  hash_key            = var.hash_key
  stream_enabled      = var.stream_enabled
  stream_view_type    = var.stream_view_type
  
  deletion_protection_enabled   = true
  
  point_in_time_recovery {
    enabled = true
  }
  
  ttl {
 // enabling TTL
  enabled = true 
 // the attribute name which enforces  TTL, must be a Number      (Timestamp)
  attribute_name = "expiryPeriod" 
 }
 
 

server_side_encryption { 
  enabled = true 
  } 

lifecycle { ignore_changes = [ "write_capacity", "read_capacity" ] }
  attribute {
    name = "Id"
    type = "S"
  }

  global_secondary_index {
    name            = "SearchByUuid"
    hash_key        = var.secondary_hash_key
    write_capacity  = var.secondary_write_capacity
    read_capacity   = var.secondary_read_capacity
    projection_type = "ALL"
  }

}
