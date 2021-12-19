# author: Ethosa
import tables


const
  color_list* = {
    "white": (255u8, 255u8, 255u8, 255u8),
    "black": (0u8, 0u8, 0u8, 255u8),
  }.toTable()
