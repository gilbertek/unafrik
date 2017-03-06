defmodule Unafrik.MessageView do
  use Unafrik.Web, :view

  def inquiry_types do
    InquiryTypeEnum.__enum_map__()
    |> Enum.map(fn({k, v}) -> {k, v} end)
  end
end
