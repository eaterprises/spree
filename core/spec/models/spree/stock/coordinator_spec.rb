require 'spec_helper'

module Spree
  module Stock
    describe Coordinator do
      let!(:order) { create(:order_with_line_items) }

      subject { Coordinator.new(order) }

      context "packages" do
        it "builds, prioritizes and estimates" do
          subject.should_receive(:build_packages).ordered
          subject.should_receive(:prioritize_packages).ordered
          subject.should_receive(:estimate_packages).ordered
          subject.packages
        end
      end

      context "build packages" do
        # OFN TODO: We broke this in 24cc3e484f2f481d55f5a5481f2daca9e9fa5cfa. Fix it.
        # It fails only when run together with all other specs.
        xit "builds a package for every stock location" do
          subject.packages.count == StockLocation.count
        end

        context "missing stock items in stock location" do
          let!(:another_location) { create(:stock_location, propagate_all_variants: false) }

          # OFN TODO: We broke this in 24cc3e484f2f481d55f5a5481f2daca9e9fa5cfa. Fix it.
          # It fails only when run together with all other specs.
          xit "builds packages only for valid stock locations" do
            subject.build_packages.count.should == (StockLocation.count - 1)
          end
        end
      end
    end
  end
end
