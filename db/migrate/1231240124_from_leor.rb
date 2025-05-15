class RemoveQuoteRequestWithOrderChatRooms < ActiveRecord::Migration[7.2]
  def up
    # Subquery to find the duplicates (repeated in each delete operation)
    query = <<~SQL
      SELECT cr1.id
      FROM chat_rooms cr1
      WHERE cr1.owner_type = 'QuoteRequest'
        AND cr1.shipment_reference IS NOT NULL
        AND EXISTS (
          SELECT 1
          FROM chat_rooms cr2
          WHERE cr2.chat_room_type = cr1.chat_room_type
            AND cr2.shipment_reference = cr1.shipment_reference
            AND cr2.id != cr1.id
        )
    SQL

    # Step 1: Delete internal_notes for the duplicate chat_rooms
    execute <<~SQL
      DELETE FROM internal_notes
      WHERE chat_room_id IN (#{query});
    SQL

    # Step 2: Delete CNRs for the duplicate chat_rooms
    execute <<~SQL
      DELETE FROM chat_notification_recipients
      WHERE chat_room_id IN (#{query});
    SQL

    # Step 3: Delete the duplicate chat_rooms
    execute <<~SQL
      DELETE FROM chat_rooms
      WHERE id IN (#{query});
    SQL
  end
end