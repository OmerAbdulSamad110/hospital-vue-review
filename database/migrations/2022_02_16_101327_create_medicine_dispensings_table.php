<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMedicineDispensingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('medicine_dispensings', function (Blueprint $table) {
            $table->foreignId('request_id')->constrained('medicine_requests')
                ->onDelete('cascade');
            $table->foreignId('inventory_id')->constrained('medicine_inventories')
                ->onDelete('cascade');
            $table->bigInteger('quantity');
            $table->primary(['request_id', 'inventory_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('medicine_dispensings');
    }
}
