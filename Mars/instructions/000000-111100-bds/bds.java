import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class bds extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        int[] operands = statement.getOperands();
        if ((RegisterFile.getValue(operands[0]) == 0) || (RegisterFile.getValue(operands[1]) == 0))
        {
        // Note: no exceptions and undefined results for zero div
        // COD3 Appendix A says "with overflow" but MIPS 32 instruction set
        // specification says "no arithmetic exception under any circumstances".
           return;
        }
     
        long unsignedNum1 = RegisterFile.getValue(operands[0]) & 0xFFFFFFFFL;
        long unsignedNum2 = RegisterFile.getValue(operands[1]) & 0xFFFFFFFFL;
        long bigOne,SmallOne;
        if (unsignedNum1 < unsignedNum2) {
            bigOne = unsignedNum2;
            SmallOne = unsignedNum1;
        } else  {
            bigOne = unsignedNum1;
            SmallOne = unsignedNum2;
        }
        // Register 33 is HIGH and 34 is LOW
        RegisterFile.updateRegister(33, (int)(bigOne % SmallOne));
        RegisterFile.updateRegister(34, (int)(bigOne / SmallOne));
    }

    @Override
    public String getExample() {
        return "bds $t1,$t2";
    }

    @Override
    public String getDescription() {
        return "bds";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.R_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "000000 fffff sssss 00000 00000 111100";
    }
}
