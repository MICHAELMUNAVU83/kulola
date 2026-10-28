defmodule Kulola.Repo.Migrations.AddFulfilmentDetailsToOrders do
  use Ecto.Migration

  def change do
    create table(:delivery_areas) do
      add :name, :string, null: false
      add :fee, :integer, null: false, default: 0
      add :active, :boolean, null: false, default: true
      add :position, :integer, null: false, default: 0
      timestamps(type: :utc_datetime)
    end

    create unique_index(:delivery_areas, [:name])

    execute """
            INSERT INTO delivery_areas (name, fee, active, position, inserted_at, updated_at) VALUES
              ('CBD / City Centre', 250, true, 0, NOW(), NOW()),
              ('Kilimani', 300, true, 1, NOW(), NOW()),
              ('Kileleshwa', 300, true, 2, NOW(), NOW()),
              ('Lavington', 350, true, 3, NOW(), NOW()),
              ('Westlands', 350, true, 4, NOW(), NOW()),
              ('Parklands', 350, true, 5, NOW(), NOW()),
              ('South B / South C', 350, true, 6, NOW(), NOW()),
              ('Lang''ata', 400, true, 7, NOW(), NOW()),
              ('Karen', 500, true, 8, NOW(), NOW()),
              ('Roysambu / Kasarani', 450, true, 9, NOW(), NOW()),
              ('Embakasi', 500, true, 10, NOW(), NOW()),
              ('Other', 0, true, 11, NOW(), NOW())
            """,
            "DELETE FROM delivery_areas"

    alter table(:orders) do
      add :order_type, :string, null: false, default: "delivery"
      add :location_scope, :string, null: false, default: "nairobi"
      add :delivery_area, :string
      add :estate, :string
      add :building, :string
      add :unit_number, :string
      add :floor, :string
      add :delivery_instructions, :text
      add :delivery_fee, :integer, null: false, default: 0
      add :courier, :string
      add :fitting_date, :date
      add :fitting_time, :string
      add :additional_items, :text
    end

    create index(:orders, [:order_type])
    create index(:orders, [:fitting_date])
  end
end
