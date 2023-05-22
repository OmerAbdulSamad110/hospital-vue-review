<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMedicineInventoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('medicine_inventories', function (Blueprint $table) {
            $table->id();
            $table->string('patch_no')->unique();
            $table->bigInteger('quantity');
            $table->date('expired_at');
            $table->date('produced_at');
            $table->unsignedBigInteger('medicine_id');
            $table->unsignedBigInteger('medicine_order_id')->nullable();
            $table->timestamps();

            $table->foreign('medicine_id')->references('id')->on('medicines')->onDelete('cascade');
            $table->foreign('medicine_order_id')->references('id')->on('medicine_orders');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('medicine_inventories');
    }
}
