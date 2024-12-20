import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;


public class bhwal extends BranchOperation implements AdditionalInstruction {

    private boolean isHuiWen(int value1, int value2) {
        boolean flag = true;
        String v1 = String.format("%32s", Integer.toBinaryString(value1)).replace(' ', '0');
        String v2 = String.format("%32s", Integer.toBinaryString(value2)).replace(' ', '0');
    
        for (int i = 0; i < 32; i++) {
            if (v1.charAt(i) != v2.charAt(31 - i)) {
                flag = false;
                break;
            }
        }
        return flag;
    }
    

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        int[] operands = statement.getOperands();
        if (isHuiWen(RegisterFile.getValue(operands[0]),RegisterFile.getValue(operands[1]))) {
            processReturnAddress(31);
            processBranch(operands[2]);
        }
    }

    @Override
    public String getExample() {
        return "bhwal $t0,$t1,label";
    }

    @Override
    public String getDescription() {
        return "bhwal";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.I_BRANCH_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111000 fffff sssss tttttttttttttttt";
    }
}
